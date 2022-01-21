import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tenders/widgets/common/custom/input.dart';
import 'package:tenders/widgets/common/custom/input_controllers.dart';
import 'package:tuple/tuple.dart';

class Dropdown<T> extends StatefulWidget {
  /// options for dropdown
  final Map<T, String> options;

  final void Function(dynamic)? onChange; // not sure why arg T threw ?? TODO:
  final double? width;
  final InputController? controller;
  final String? hint;

  /// given a [T] optionally build the corresponding widget. If T is null that means no value is selected
  final Widget Function(T?)? widgetBuilder;

  const Dropdown({
    required this.options,
    this.onChange,
    this.width,
    this.controller,
    this.widgetBuilder,
    this.hint,
  });

  @override
  _DropdownState<T> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown> {
  // TODO: figure out why this template T does not match widget<T> for some reason
  OverlayEntry? _overlay;
  late final InputController _controller;

  void _onSelection(T? val) {
    toggle();
    if (val == null) return;
    _controller.text = widget.options[val]!;
    try {
      widget.onChange?.call(val);
    } catch (er) {
      log("error $er");
    }
  }

  void toggle() {
    if (_controller.disabled) return;
    if (_overlay == null) {
      _overlay = createOverlayEntry<T>(
          textAlign: TextAlign.left,
          elementHeight: context.size?.height ?? 50,
          options: widget.options as Map<T, String>,
          context: context,
          widgetBuilder: widget.widgetBuilder,
          noScroll: true,
          onSelection: _onSelection);
      Overlay.of(context)!.insert(_overlay!);
    } else {
      _overlay!.remove();
      _overlay = null;
    }
    setState(() {});
  }

  @override
  void initState() {
    _controller = widget.controller ?? InputController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget current = Input(
      isDense: true,
      hint: widget.hint,
      contentPadding: EdgeInsets.fromLTRB(8, 8, 0, 10),
      simple: true,
      radius: Radius.circular(5),
      focusedElevation: 1,
      unfocusedElevation: 1,
      controller: _controller,
      focusNode: AlwaysDisabledFocusNode(),
      suffixIcon: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _overlay == null ? Icons.arrow_drop_down : Icons.arrow_drop_up,
            ),
          ],
        ),
      ),
    );

    if (widget.width != null) {
      current = SizedBox(
        width: widget.width,
        child: current,
      );
    }

    // major hack for now to show widget builder for dropdown.
    // TODO: refactor dropdwon at some point
    if (widget.widgetBuilder != null) {
      current = Stack(
        children: [
          current,
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surface,
              ),
              padding: EdgeInsets.all(8),
              child: widget
                  .widgetBuilder!(widget.options[widget.controller?.text]),
            ),
          )
        ],
      );
    }

    //steal child's taps
    current = InkWell(
        child: IgnorePointer(
          child: current,
        ),
        onTap: toggle);

    return current;
  }
}

OverlayEntry createOverlayEntry<T>(
    {double elementHeight = 0,
    required BuildContext context,
    required Map<T, String> options,
    required void Function(T?) onSelection,
    final Widget Function(T)? widgetBuilder,
    TextAlign textAlign = TextAlign.center,
    bool noScroll = false}) {
  final media = MediaQuery.of(context);
  final screen = MediaQuery.of(context).size;
  RenderBox renderBox = context.findRenderObject() as RenderBox;
  var size = renderBox.size;

  final _myOffset = renderBox.localToGlobal(Offset.zero);

  final _onTop = _myOffset.dy > (screen.height / 2.0);

  final offsetY = _onTop
      ? (screen.height - _myOffset.dy + 2)
      : (_myOffset.dy + elementHeight + 2);

//calculate if our expanded height goes past the screen
  final expandedHeight = options.length * elementHeight;
  final availableHeight = screen.height - offsetY;
  final scrollable =
      expandedHeight > availableHeight - media.padding.vertical - 16;

  return OverlayEntry(
      builder: (context) => SafeArea(
            top: _onTop ? true : false,
            bottom: _onTop ? false : true,
            child: Stack(
              children: [
                if (noScroll) //if no scroll, close when tap anywhere outside
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () => onSelection(null),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      )),
                Positioned(
                  left: _myOffset.dx,
                  top: _onTop ? (scrollable ? 8 : null) : offsetY,
                  width: size.width,
                  bottom: _onTop ? offsetY : (scrollable ? 8 : null),
                  child: Material(
                    borderRadius: BorderRadius.circular(6),
                    elevation: 4.0,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: textAlign == TextAlign.left ? 8.0 : 0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: options.entries
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      onSelection(e.key);
                                    },
                                    child: SizedBox(
                                      height: elementHeight,
                                      child: Align(
                                        alignment: textAlign == TextAlign.left
                                            ? Alignment.centerLeft
                                            : Alignment.center,
                                        child: widgetBuilder == null
                                            ? Text(
                                                e.value,
                                                textAlign: textAlign,
                                              )
                                            : widgetBuilder(e.key),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
