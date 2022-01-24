import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class SwipeControls extends StatefulWidget {
  final Widget child;
  const SwipeControls({required this.child});
  @override
  State<SwipeControls> createState() => _SwipeControlsState();
}

class _SwipeControlsState extends State<SwipeControls>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  final milliseconds = 4000;
  bool shown = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: milliseconds),
    );
    animationController.addListener(() {
      setState(() {});
    });
    animationController.repeat();
    SharedPreferences.getInstance().then((value) {
      if (value.getBool("hideControls") == true) {
        setState(() {
          shown = true;
        });
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _stop(dynamic d) {
    setState(() {
      shown = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shown) return widget.child;
    const alpha = 100;

    return GestureDetector(
      onTapDown: _stop,
      onPanDown: _stop,
      onVerticalDragDown: _stop,
      onHorizontalDragDown: _stop,
      onLongPressDown: _stop,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Positioned.fill(child: widget.child),
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 1, //1 - animationController.value,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: animationController.value >= 0.5
                            ? (animationController.value < 0.9
                                ? Color.lerp(
                                    Colors.black.withAlpha(alpha),
                                    Color(0xff0f0000),
                                    (animationController.value - 0.5) *
                                        (10.0 / 4.0),
                                  )
                                : Color.lerp(
                                    Color(0xff0f0000),
                                    Colors.black.withAlpha(alpha),
                                    (animationController.value - 0.9) * 10,
                                  ))
                            : Colors.black.withAlpha(alpha),
                        child: Center(
                          child:
                              Icon(Icons.cancel, color: Colors.red, size: 50),
                        ),
                      ),
                    ),
                    Container(
                      width: 2,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: animationController.value < 0.4
                            ? (Color.lerp(
                                Colors.black.withAlpha(alpha),
                                Color(0xff000f01),
                                animationController.value * (10.0 / 4.0),
                              ))
                            : (animationController.value < 0.5
                                ? Color.lerp(
                                    Color(0xff000f01),
                                    Colors.black.withAlpha(alpha),
                                    (animationController.value - 0.4) * 10,
                                  )
                                : Colors.black.withAlpha(alpha)),
                        child: Center(
                          child:
                              Icon(Icons.check, color: Colors.green, size: 50),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.swipe,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
