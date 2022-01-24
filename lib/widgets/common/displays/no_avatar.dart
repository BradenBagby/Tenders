import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:collection/collection.dart';

import 'package:tenders/domain/member/member.dart';

class NoAvatar extends StatelessWidget {
  final bool large;
  final Member? member;
  final double size;
  final showInitial;
  const NoAvatar(
      {this.large = false,
      required this.member,
      required this.size,
      this.showInitial = true});

  static const PossibleColors = [
    Color(0xffFF512F),
    Color(0xffF09819),
    Color(0xff9F2B00),
    Colors.amber,
    Colors.orange,
    Colors.red,
    Colors.blue,
    Colors.tealAccent,
    Colors.purple,
    Colors.green,
    Colors.white,
    Colors.black,
  ];
  @override
  Widget build(BuildContext context) {
    final color = member == null ? PossibleColors.first : Color(member!.color);
    return Container(
      color: color,
      padding: EdgeInsets.all(2),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
                "assets/${large ? 'justTender.png' : 'tender_loader.png'}"),
          ),
          Center(
            child: Text(
              member?.name.characters.firstOrNull ?? '',
              style: TextStyle(fontSize: size / 2, color: color),
            ),
          )
        ],
      ),
    );
  }
}
