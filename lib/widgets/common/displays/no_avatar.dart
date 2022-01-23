import 'package:flutter/material.dart';
import 'dart:math' as math;

class NoAvatar extends StatelessWidget {
  final bool large;
  final String id;
  final String? initials;
  final double size;
  const NoAvatar(
      {this.large = false,
      required this.id,
      required this.initials,
      required this.size});

  static const PossibleColors = [
    Color(0xffFF512F),
    Color(0xffF09819),
    Colors.white,
    Color(0xff9F2B00),
    Colors.black,
    Colors.yellow,
    Colors.orange,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    final color = PossibleColors[id.hashCode % (PossibleColors.length - 1)];
    return Container(
      color: color,
      padding: EdgeInsets.all(2),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
                "assets/${large ? 'justTender.png' : 'tender_loader.png'}"),
          ),
          if (initials != null)
            Center(
              child: Text(
                initials!,
                style: TextStyle(fontSize: size * 0.5, color: color),
              ),
            )
        ],
      ),
    );
  }
}
