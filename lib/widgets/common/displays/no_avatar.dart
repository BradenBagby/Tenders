import 'package:flutter/material.dart';
import 'dart:math' as math;

class NoAvatar extends StatelessWidget {
  final bool large;
  final String id;
  const NoAvatar({this.large = false, required this.id});

  static const PossibleColors = [
    Color(0xffFF512F),
    Color(0xffF09819),
    Colors.white,
    Color(0xff9F2B00),
    Colors.black,
    Colors.yellow,
    Colors.orange,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PossibleColors[id.hashCode % 6],
      padding: EdgeInsets.all(2),
      child: Image.asset(
          "assets/${large ? 'justTender.png' : 'tender_loader.png'}"),
    );
  }
}
