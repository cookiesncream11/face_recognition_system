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
    return SizedBox(
      width: 150, // Specify the size for the pie chart
      height: 150,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: onTimeCount.toDouble(),
              title: 'On Time',
              color: Colors.green,
              radius: 60,
            ),
            PieChartSectionData(
              value: lateCount.toDouble(),
              title: 'Late',
              color: Colors.red,
              radius: 60,
            ),
            PieChartSectionData(
              value: absentCount.toDouble(),
              title: 'Absent',
              color: Colors.grey,
              radius: 60,
            ),
          ],
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 40,
          sectionsSpace: 2,
        ),
      ),
    );
  }
}
