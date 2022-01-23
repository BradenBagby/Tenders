import 'dart:math' as math;

import 'dart:ui';

import 'package:flutter/material.dart';

Map<String, dynamic> toMap(dynamic d) =>
    Map<String, dynamic>.from(d as Map<dynamic, dynamic>);

List<Map<String, dynamic>> toList(dynamic d) =>
    List<Map<String, dynamic>>.from(d as Iterable<dynamic>);

/// in miles
double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = math.cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return (12742 * math.asin(math.sqrt(a))) / 1.609;
}

final onlyNumbersRegex = RegExp(r'\D');
String formatPhone(String phone, {bool visual = false}) {
  // remove everything but numbers
  String clean = phone.replaceAll(onlyNumbersRegex, "");

  // remove leading 1
  if (clean.length > 10 && clean[0] == "1") {
    clean = clean.substring(1);
  }

  try {
    if (visual) {
      return "(${clean.substring(0, 3)}) ${clean.substring(3, 6)}-${clean.substring(6, 10)}";
    }
    return clean;
  } catch (er) {
    return phone;
  }
}

/// calcluates sizes needed for this text
Size textSize(
    {required String text, required TextStyle style, int maxLines = 1}) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
