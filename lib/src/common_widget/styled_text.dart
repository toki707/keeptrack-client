import 'package:flutter/material.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/theme/theme.dart';


class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    super.key,
    this.fontSize = Sizes.p12,
    this.color = AppColors.textColor,
    this.maxLines,
  });

  final String text;
  final double fontSize;
  final Color color;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
