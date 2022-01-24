import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tenders/domain/member/member.dart';

class NoAvatar extends StatelessWidget {
  final bool large;
  final Member? member;
  final double size;
  const NoAvatar(
      {this.large = false, required this.member, required this.size});

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
    return Container(
      color: member == null ? PossibleColors.first : Color(member!.color),
      padding: EdgeInsets.all(2),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
                "assets/${large ? 'justTender.png' : 'tender_loader.png'}"),
          ),
        ],
      ),
    );
  }
}
