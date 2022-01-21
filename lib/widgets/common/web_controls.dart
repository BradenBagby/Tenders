import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// shows arrows for sliding left and right on web
class WebPageControls extends StatefulWidget {
  final void Function(bool accepted) onTap;
  final Widget child;
  const WebPageControls({required this.onTap, required this.child});

  @override
  State<WebPageControls> createState() => _WebPageControlsState();
}

class _WebPageControlsState extends State<WebPageControls> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    // only on web
    if (!kIsWeb || true) return widget.child;

    return Stack(
      children: [
        widget.child,
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 50,
          child: _control(
              icon: Icons.check,
              color: Colors.green,
              onTap: () {
                widget.onTap(false);
              }),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: 50,
          child: _control(
              icon: Icons.cancel,
              color: Colors.red,
              onTap: () {
                widget.onTap(true);
              }),
        )
      ],
    );
  }

  Widget _control(
      {required VoidCallback onTap,
      required IconData icon,
      required Color color}) {
    return MouseRegion(
      onEnter: (event) => _toggleHover(true),
      onExit: (event) => _toggleHover(false),
      child: Container(
        color: Colors.black.withAlpha(hover ? 100 : 0),
        child: Center(
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleHover(bool on) {
    setState(() {
      hover = on;
    });
  }
}
