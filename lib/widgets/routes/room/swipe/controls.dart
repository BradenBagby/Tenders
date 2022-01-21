import 'package:flutter/material.dart';

class SwipeControls extends StatefulWidget {
  final Widget child;
  const SwipeControls({required this.child});
  @override
  State<SwipeControls> createState() => _SwipeControlsState();
}

class _SwipeControlsState extends State<SwipeControls>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const alpha = 100;
    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        Positioned.fill(
            child: IgnorePointer(
                child: Opacity(
          opacity: 1 - animationController.value,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black.withAlpha(alpha),
                  child: Center(
                    child: Icon(Icons.cancel, color: Colors.red, size: 50),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text("Swipe",
                      style: Theme.of(context).textTheme.headline4),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black.withAlpha(alpha),
                  child: Center(
                    child: Icon(Icons.cancel, color: Colors.green, size: 50),
                  ),
                ),
              )
            ],
          ),
        )))
      ],
    );
  }
}
