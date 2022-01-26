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

  static final PossibleColors = [
    Color(0xffFF512F),
    Color(0xffF09819),
    Color(0xff9F2B00),
    Color(0xffffc107),
    Color(0xffff9800),
    Color(0xffb71c1c),
    Color(0xff2196F3),
    Color(0xff009688),
    Color(0xff9c27b0),
    Color(0xff4caf50),
    Color(0xffffffff),
    Color(0xff000000),
  ];
  @override
  Widget build(BuildContext context) {
    final color = member == null ? PossibleColors.first : Color(member!.color);
    return Container(
      color: color,
      padding: EdgeInsets.all(4),
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
