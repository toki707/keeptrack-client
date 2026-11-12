import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/theme/theme.dart';

class LapTimesChart extends StatelessWidget {
  const LapTimesChart({super.key});

  static const points = [
    FlSpot(0, -102.3),
    FlSpot(1, -101.1),
    FlSpot(2, -100.2),
    FlSpot(3, -99.5),
    FlSpot(4, -100.8),
    FlSpot(5, -101.6),
    FlSpot(6, -100.0),
  ];
  static const moyenne = -100.8;
  static const indexMeilleur = 3;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final estMeilleur = value.toInt() == indexMeilleur;

    return SideTitleWidget(
      meta: meta,
      space: Sizes.p2,
      child: StyledText(
        "T${value.toInt() + 1}",
        fontSize: Sizes.p8,
        color: estMeilleur ? AppColors.textBestLap : AppColors.textMuted,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final secondes = -value.toInt();
    final minutes = secondes ~/ 60;
    final reste = (secondes % 60).toString().padLeft(2, '0');

    return SideTitleWidget(
      meta: meta,
      child: StyledText(
        "$minutes:$reste",
        fontSize: Sizes.p8,
        color: AppColors.textMuted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Padding(
        padding: const EdgeInsets.only(right: Sizes.p16, top: Sizes.p8),
        child: LineChart(
          LineChartData(
            minY: -103,
            maxY: -99,
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: points,
                isCurved: true,
                preventCurveOverShooting: true,
                barWidth: 3,
                isStrokeCapRound: true,
                color: AppColors.textColor,
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.lapFaster,
                  cutOffY: moyenne,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: true,
                  color: AppColors.lapSlower,
                  cutOffY: moyenne,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: true,
                  checkToShowDot: (spot, barData) {
                    return spot.x == indexMeilleur;
                  },
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 5.5,
                      color: AppColors.textBestLap,
                      strokeColor: AppColors.textColor,
                      strokeWidth: 2,
                    );
                  },
                ),
              ),
            ],
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                HorizontalLine(
                  y: moyenne,
                  color: AppColors.textColor,
                  strokeWidth: 2,
                  dashArray: [6, 5],
                ),
              ],
              verticalLines: [
                VerticalLine(
                  x: indexMeilleur.toDouble(),
                  color: AppColors.textBestLap,
                  strokeWidth: 1.5,
                  dashArray: [3, 3],
                ),
              ],
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: Sizes.p24,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: Sizes.p48,
                  interval: 1,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: AppColors.cardBorder),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(color: AppColors.dividerGrey, strokeWidth: 1);
              },
            ),
          ),
        ),
      ),
    );
  }
}