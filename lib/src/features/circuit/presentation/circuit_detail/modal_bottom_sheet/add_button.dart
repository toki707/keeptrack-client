import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/theme/theme.dart';

class AddButton extends StatelessWidget {
  const new({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.addButtonBorder),
          borderRadius: BorderRadius.circular(Sizes.p16),
          gradient: LinearGradient(
            begin: .topLeft,
            end: .bottomRight,
            colors: [AppColors.addButtonStart, AppColors.addButtonEnd],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p12),
          child: StyledText("Ajouter", fontSize: Sizes.p16),
        ),
      ),
    );
  }
}
