import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/widgets/common/custom/input_controllers.dart';

/// input that resizes its width to fit the current input
class ResizeInput extends StatefulWidget {
  final InputController controller;
  final FocusNode? focusNode;
  final TextStyle? style;
  final String hint;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  // onchange
  const ResizeInput(
      {required this.controller,
      this.focusNode,
      this.style,
      required this.hint,
      this.keyboardType,
      this.onChanged,
      this.onSubmitted,
      this.textInputAction,
      this.textCapitalization = TextCapitalization.none});
  @override
  State<ResizeInput> createState() => _ResizeInputState();
}

class _ResizeInputState extends State<ResizeInput> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText2!.merge(widget.style);
    return Column(
      children: [
        Container(
          width: textSize(text: widget.controller.text, style: style).width,
          constraints: BoxConstraints(
              minWidth: widget.controller.text.isNotEmpty
                  ? 0
                  : textSize(text: widget.hint, style: style).width),
          child: TextField(
            style: style,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: style.copyWith(
                  color: style.color!.withAlpha(155),
                  fontWeight: FontWeight.w300),
              hintText: widget.hint,
            ),
          ),
        ),
        if (widget.controller.error != null)
          Text(
            widget.controller.error!,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).colorScheme.error),
          )
      ],
    );
  }
}
