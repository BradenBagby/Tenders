import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';

import 'input_controllers.dart';

enum JoinedSide { LEFT, RIGHT }

class Input extends StatefulWidget {
  final String? label;
  final TextInputAction? textInputAction;
  final InputController? controller;
  final FocusNode? focusNode;
  final double? unfocusedElevation;
  final double? focusedElevation;
  final JoinedSide? joinedSide;
  final TextInputType keyboardType;
  final EdgeInsets? contentPadding;
  final FloatingLabelBehavior floatingLabelBehavior;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Radius radius;
  final bool simple;
  final String? hint;
  final Widget? suffixIcon;
  final bool isDense;
  final int? maxLines;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  const Input({
    this.label,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.controller,
    this.hint,
    this.focusNode,
    this.onChanged,
    this.backgroundColor,
    this.hintStyle,
    this.isDense = false,
    this.maxLines = 1,
    this.suffixIcon,
    this.onSubmitted,
    this.unfocusedElevation,
    this.focusedElevation,
    this.contentPadding,
    this.radius = const Radius.circular(100),
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.joinedSide,
    this.simple = false,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  late final InputController _controller;
  late final FocusNode _focusNode;

  double get _unfocusedElevation =>
      widget.unfocusedElevation ??
      Theme.of(context)
          .elevatedButtonTheme
          .style!
          .elevation!
          .resolve({MaterialState.selected})!;
  double get _focusedElevation => widget.focusedElevation ?? 1;

  @override
  void initState() {
    _controller = widget.controller ?? InputController();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (mounted) setState(() {});
    });

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.joinedSide == null
        ? BorderRadius.circular(widget.radius.x)
        : BorderRadius.only(
            bottomLeft: widget.joinedSide != JoinedSide.LEFT
                ? widget.radius
                : Radius.zero,
            topLeft: widget.joinedSide != JoinedSide.LEFT
                ? widget.radius
                : Radius.zero,
            topRight: widget.joinedSide != JoinedSide.RIGHT
                ? widget.radius
                : Radius.zero,
            bottomRight: widget.joinedSide != JoinedSide.RIGHT
                ? widget.radius
                : Radius.zero);

    final border = widget.simple
        ? UnderlineInputBorder(
            borderRadius: BorderRadius.all(widget.radius),
            borderSide: BorderSide.none)
        : OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: borderRadius,
          );

    final errorBorder = border;

    return Material(
      elevation: _controller.error != null
          ? 0
          : (_focusNode.hasFocus ? _focusedElevation : _unfocusedElevation),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: TextField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        focusNode: _focusNode,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        maxLines: widget.maxLines,
        textAlign: widget.textAlign,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
            isDense: widget.isDense,
            hintText: widget.hint,
            /* prefixIconConstraints: BoxConstraints(minWidth: 2),
            prefixIcon: widget.controller?.prefixText != null
                ? Container(
                    padding: EdgeInsets.only(top: 4),
                    alignment: Alignment.centerRight,
                    constraints: BoxConstraints(maxWidth: 16, minWidth: 2),
                    child: Text(widget.controller!.prefixText!),
                  )
                : null,*/
            prefixText: _controller.prefixText,
            hintStyle: widget.hintStyle,
            suffix: widget.suffixIcon,
            suffixIcon: _controller.loading ? const Loader() : null,
            contentPadding: widget.contentPadding,
            fillColor:
                widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            filled: true,
            focusedErrorBorder: errorBorder,
            errorBorder: errorBorder,
            labelText: widget.label,
            enabledBorder: border,
            errorText: _controller.success ?? _controller.error,
            errorStyle: _controller.success != null
                ? Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.green)
                : null,
            focusedBorder: border,
            border: border),
      ),
    );
  }
}


/*
Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50.0), boxShadow: [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 8,
          color: Theme.of(context).shadowColor,
        )
      ]),
*/