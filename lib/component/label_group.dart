import 'package:flutter/material.dart';

class LabelGroup extends StatelessWidget {
  final String labelText;
  final TextStyle? labelStyle;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const LabelGroup({
    Key? key,
    required this.labelText,
    this.labelStyle,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: labelStyle ?? Theme.of(context).inputDecorationTheme?.labelStyle,
          ),
          child,
        ],
      ),
    );
  }
}
