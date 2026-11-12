import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/theme/theme.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyledText(label, fontSize: Sizes.p8, color: AppColors.textLabel),
        StyledText(value, fontSize: Sizes.p12),
      ],
    );
  }
}
