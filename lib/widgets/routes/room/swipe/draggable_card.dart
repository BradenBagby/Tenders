import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// TODO: clean this up
class DraggableCard extends StatefulWidget {
  const DraggableCard(
      {required this.child,
      Key? key,
      this.acceptOverlay,
      this.denyOverlay,
      this.onAccept,
      this.onReject})
      : super(key: key);

  final Widget child;
  final Widget? acceptOverlay;
  final Widget? denyOverlay;
  final void Function()? onAccept;
  final void Function()? onReject;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// The alignment of the card as it is dragged or being animated.
  ///
  /// While the card is being dragged, this value is set to the values computed
  /// in the GestureDetector onPanUpdate callback. If the animation is running,
  /// this value is set to the value of the [_animation].
  Offset _dragOffset = Offset.zero;

  late Animation<Offset> _animation;
  Offset? start;

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      Tween(begin: _dragOffset, end: Offset.zero),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  /// TODO: can make this better, pixelsPerSecond needs to not be there. i am so tired rn
  void _runAcceptAnimation(
      Offset pixelsPerSecond, Size size, DragEndDetails endDetails) {
    final endPos = (start! + _dragOffset);
    final movement = (endPos - start!);
    final normalized = movement / movement.distance;
    final end =
        endPos + (normalized * endDetails.velocity.pixelsPerSecond.distance);

    _animation = _controller.drive(
      Tween(begin: _dragOffset, end: end),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragOffset = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget? overlay;
    final acceptBounds = size.width * (1.0 / 4.0);
    final denyBounds = size.width * -(1.0 / 4.0);
    if (_dragOffset.dx > acceptBounds) {
      final opacity = (_dragOffset.dx - acceptBounds) / acceptBounds;
      overlay = Opacity(
        opacity: opacity > 1 ? 1 : opacity,
        child: widget.acceptOverlay,
      );
    } else if (_dragOffset.dx < denyBounds) {
      final opacity = (_dragOffset.dx - denyBounds) / -acceptBounds;
      overlay = Opacity(
        child: widget.denyOverlay,
        opacity: opacity > 1 ? 1 : opacity,
      );
    }
    return GestureDetector(
        onPanDown: (details) {
          start = details.globalPosition;
          _controller.stop();
        },
        onPanUpdate: (details) {
          final change = details.globalPosition - start!;
          setState(() {
            _dragOffset = change;
          });
        },
        onPanEnd: (details) {
          // check if this has been accepted or rejected
          final acceptBounds = size.width * (2.0 / 5.0);
          final denyBounds = size.width * -(2.0 / 5.0);
          if (_dragOffset.dx > acceptBounds) {
            _runAcceptAnimation(
                details.velocity.pixelsPerSecond, size, details);
            widget.onAccept?.call();
          } else if (_dragOffset.dx < denyBounds) {
            _runAcceptAnimation(
                details.velocity.pixelsPerSecond, size, details);
            widget.onReject?.call();
          } else {
            _runAnimation(details.velocity.pixelsPerSecond, size);
          }
        },
        child: Transform.translate(
          offset: _dragOffset,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                widget.child,
                if (overlay != null) Positioned.fill(child: overlay)
              ],
            ),
          ),
        ));
  }
}
