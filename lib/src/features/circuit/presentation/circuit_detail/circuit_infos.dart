import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/info_item.dart';
import 'package:keeptrack/src/common_widget/section_title.dart';
import 'package:keeptrack/src/common_widget/styled_card.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/circuit/domain/circuit.dart';
import 'package:keeptrack/theme/theme.dart';

class CircuitCaracteristiques extends StatefulWidget {
  const CircuitCaracteristiques(this.circuit, {super.key});

  final Circuit circuit;

  @override
  State<CircuitCaracteristiques> createState() =>
      _CircuitCaracteristiquesState();
}

class _CircuitCaracteristiquesState extends State<CircuitCaracteristiques> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final circuit = widget.circuit;

    return StyledCard(
      padding: .symmetric(horizontal: Sizes.p12, vertical: Sizes.p16),
      child: ExpansionTile(
        initiallyExpanded: true,
        shape: Border(),
        trailing: SizedBox.shrink(),
        onExpansionChanged: (expanded) =>
            setState(() => _isExpanded = expanded),
        title: SectionTitle(
          "Caracteristiques :",
          trailing: AnimatedRotation(
            turns: _isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textColor,
            ),
          ),
        ),
        children: [
          Image.asset(circuit.outline!),
          gapH12,
          Divider(thickness: 1, color: AppColors.dividerGrey),
          _infoRow(
            InfoItem(label: "Date de creation", value: "${circuit.yearCreation!}"),
            InfoItem(label: "Nombre de boxes", value: "${circuit.pitboxes}"),
          ),
          Divider(thickness: 1, color: AppColors.dividerGrey),
          _infoRow(
            InfoItem(label: "Longueur", value: "${circuit.lengthKm}"),
            InfoItem(label: "Sens", value: "${circuit.run}"),
          ),
          Divider(thickness: 1, color: AppColors.dividerGrey),
          _infoRow(
            InfoItem(
              label: "Point le plus haut",
              value: "${circuit.highestPoint}",
            ),
            InfoItem(
              label: "point le plus bas",
              value: "${circuit.lowestPoint}",
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(InfoItem left, InfoItem right) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: left),
          Expanded(child: right),
        ],
      ),
    );
  }
}
