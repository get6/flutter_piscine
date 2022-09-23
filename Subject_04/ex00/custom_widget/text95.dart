import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';

class Text95 extends StatelessWidget {
  final String title;
  final TextStyle style;
  const Text95(
    this.title, {
    super.key,
    this.style = Flutter95.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style == Flutter95.textStyle
          ? style
          : Flutter95.textStyle.merge(style),
    );
  }
}
