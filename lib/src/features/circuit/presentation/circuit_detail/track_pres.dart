import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/flag_avatar.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/circuit/domain/circuit.dart';
import 'package:keeptrack/theme/theme.dart';

class TrackPres extends StatelessWidget {
  const new(this.circuit, {super.key});

  final Circuit circuit;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(Sizes.p12),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            crossAxisAlignment: .center,
            children: [
              FlagAvatar(circuit.location),
              gapW8,
              SizedBox(
                width: size.width * 0.7,
                child: StyledText(circuit.name!, fontSize: Sizes.p24),
              ),
            ],
          ),
          gapH4,
          StyledText(circuit.description!, fontSize: Sizes.p16),
          gapH16,
          StyledText(
            "${circuit.country}, ${circuit.city}",
            fontSize: Sizes.p12,
            color: AppColors.textLight,
          ),
        ],
      ),
    );
  }
}
