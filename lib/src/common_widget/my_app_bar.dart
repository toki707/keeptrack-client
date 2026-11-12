import 'package:flutter/material.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/circuit/domain/circuit.dart';
import 'package:keeptrack/theme/theme.dart';

class MyAppBar extends StatelessWidget {
  const new({super.key, this.circuit});

  final Circuit? circuit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (circuit != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color: AppColors.textColor,
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Expanded(child: SizedBox(width: 0)),
                      Image.asset(
                        "assets/images/keeptrack_icon.png",
                        width: Sizes.p36,
                      ),
                    ],
                  )
                else
                  Image.asset(
                    "assets/images/KeepTrack_logo.png",
                    width: Sizes.p180,
                  ),
                const SizedBox(
                  width: Sizes.p120,
                  child: Divider(color: AppColors.dividerColor, thickness: 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
