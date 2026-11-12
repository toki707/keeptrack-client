import 'package:flutter/material.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/theme/theme.dart';

class StyledDropdown extends StatelessWidget {
  const StyledDropdown({
    super.key,
    required this.label,
    required this.values,
    required this.onSelected,
    this.initialSelection,
    this.enabled = true,
  });

  final String label;
  final List<String> values;
  final ValueChanged<String?> onSelected;
  final String? initialSelection;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: Sizes.p232,
      enabled: enabled,
      initialSelection: initialSelection,
      requestFocusOnTap: true,
      label: Text(label, style: TextStyle(color: AppColors.textColor)),
      textStyle: TextStyle(color: AppColors.textColor),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.dropdownMenuColor),
      ),
      dropdownMenuEntries: values
          .map(
            (value) => DropdownMenuEntry(
              value: value,
              label: value,
              style: MenuItemButton.styleFrom(
                foregroundColor: AppColors.textColor,
              ),
            ),
          )
          .toList(),
      onSelected: onSelected,
    );
  }
}
