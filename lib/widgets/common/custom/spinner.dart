import 'dart:math' as math;
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  final double? size;
  final Duration duration;
  final Color? color;
  const Loader(
      {this.size, this.duration = const Duration(seconds: 1), this.color});

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  double angle = 0;
  late final AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        animationBehavior: AnimationBehavior.preserve);
    _controller.repeat();
    _controller.addListener(() {
      setState(() {
        angle = math.pi * -2 * _controller.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: SizedBox(
        width: widget.size ?? 24,
        height: widget.size ?? 24,
        child: Image.asset(
          "assets/tender_loader.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
