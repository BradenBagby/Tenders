import 'package:flutter/material.dart';

class Chicken extends StatelessWidget {
  final double width;
  const Chicken({required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Image.asset('assets/chicken.png'),
    );
  }
}
