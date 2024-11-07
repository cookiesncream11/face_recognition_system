import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomPieChart extends StatelessWidget {
  final int onTimeCount;
  final int lateCount;
  final int absentCount;

  const CustomPieChart({
    Key? key,
    required this.onTimeCount,
    required this.lateCount,
    required this.absentCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = onTimeCount + lateCount + absentCount;
    final onTimePercentage = (onTimeCount / total) * 100;
    final latePercentage = (lateCount / total) * 100;
    final absentPercentage = (absentCount / total) * 100;

    return SizedBox(
      width: 150,
      height: 150,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 60,
          startDegreeOffset: -90,
          sections: [
            PieChartSectionData(
              value: onTimePercentage,
              title: 'On Time',
              color: Colors.green,
              radius: 50,
              showTitle: false,
            ),
            PieChartSectionData(
              value: latePercentage,
              title: 'Late',
              color: Colors.red,
              radius: 45,
              showTitle: false,
            ),
            PieChartSectionData(
              value: absentPercentage,
              title: 'Absent',
              color: Colors.grey,
              radius: 40,
              showTitle: false,
            ),
          ],
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
