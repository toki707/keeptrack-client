import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';

class TabItem extends StatelessWidget {
  const new({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(child: StyledText(title, fontSize: Sizes.p12));
  }
}
