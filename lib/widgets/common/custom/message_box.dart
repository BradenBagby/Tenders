import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class MessageBox extends StatelessWidget {
  final double elevation;
  final Color? color;
  final String message;
  final double messageTailHeight;
  final EdgeInsets padding;
  final bool flipped;
  final bool flippedY;
  final TextStyle? style;
  const MessageBox(
      {this.message = "",
      this.elevation = 1,
      this.padding = const EdgeInsets.all(8),
      this.color,
      this.messageTailHeight = 8,
      this.flipped = false,
      this.flippedY = false,
      this.style});

  @override
  Widget build(BuildContext context) {
    Widget child = Text(
      message,
      maxLines: 10,
      style: style,
    );

    if (flipped) {
      child = Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: child);
    }
    if (flippedY) {
      child = Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(math.pi),
          child: child);
    }

/* Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: */

    Widget parent = Material(
      elevation: elevation,
      color: color,
      shape: MessageBubbleBorder(borderRadius: 4),
      child: Padding(
          padding: padding +
              EdgeInsets.only(
                  bottom:
                      messageTailHeight), //add padding so its centered in message part excluding tail
          child: child),
    );

    if (flipped) {
      parent = Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: parent);
    }
    if (flippedY) {
      parent = Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(math.pi),
          child: parent);
    }

    return parent;
  }
}

// ignore: avoid_classes_with_only_static_members
/// creates a message bubble path
class MessageBubblePath {
  static Path create(
      {required Size size,
      double radius = 20,
      double deflation = 1,
      double arrowHeight = 8}) {
    Size _size = size * deflation;
    var path = Path();
    path.moveTo(0.0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(_size.width - radius, 0);
    path.quadraticBezierTo(_size.width, 0, _size.width, radius);
    path.lineTo(_size.width, _size.height - radius - arrowHeight);
    path.quadraticBezierTo(_size.width, _size.height - arrowHeight,
        _size.width - radius, _size.height - arrowHeight);
    path.lineTo(_size.width - radius - arrowHeight, _size.height);
    path.lineTo(
        _size.width - radius - arrowHeight * 2, _size.height - arrowHeight);

    path.lineTo(radius, _size.height - arrowHeight);
    path.quadraticBezierTo(
        0, _size.height - arrowHeight, 0, _size.height - radius - arrowHeight);
    path.lineTo(0.0, radius);
    path = path.shift(Offset(
        size.width * (1 - deflation) / 2, size.height * (1 - deflation) / 2));

    return path;
  }
}

/// paints a message bubble
class MessageBubblePaint extends CustomPainter {
  final double radius;
  final double deflation;
  final double arrowHeight;
  final double width;

  const MessageBubblePaint(
      {this.radius = 20,
      this.deflation = 1,
      this.arrowHeight = 8,
      this.width = 2});

  @override
  void paint(Canvas canvas, Size s) {
    Size size = s * deflation;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(
        MessageBubblePath.create(
            size: size, deflation: deflation, radius: radius),
        paint);
  }

  @override
  bool shouldRepaint(covariant MessageBubblePaint o) {
    return radius != o.radius ||
        deflation != o.deflation ||
        arrowHeight != o.arrowHeight ||
        width != o.width;
  }
}

class MessageClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

/// creates a message bubble border shape
class MessageBubbleBorder extends OutlinedBorder {
  final double shadowRadius;
  final double borderRadius;

  const MessageBubbleBorder(
      {BorderSide side = BorderSide.none,
      this.borderRadius = 2,
      this.shadowRadius = 0.2})
      : super(side: side);

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) => CircleBorder(side: side.scale(t));

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is MessageBubbleBorder)
      return MessageBubbleBorder(side: BorderSide.lerp(a.side, side, t));
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is MessageBubbleBorder)
      return MessageBubbleBorder(side: BorderSide.lerp(side, b.side, t));
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect size, {TextDirection? textDirection}) {
    return MessageBubblePath.create(
      size: Size(size.width, size.height),
      radius: borderRadius,
      deflation: shadowRadius,
    );
  }

  @override
  Path getOuterPath(Rect size, {TextDirection? textDirection}) {
    return MessageBubblePath.create(
      size: Size(size.width, size.height),
      radius: borderRadius,
    );
  }

  @override
  MessageBubbleBorder copyWith({BorderSide? side}) {
    return MessageBubbleBorder(side: side ?? this.side);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        break; //todo:
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is MessageBubbleBorder && other.side == side;
  }

  @override
  int get hashCode => side.hashCode;

  @override
  String toString() {
    return 'MessageBubbleBorder';
  }
}
