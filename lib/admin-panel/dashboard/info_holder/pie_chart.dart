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

    // Calculate percentages for each section
    final onTimePercentage = (onTimeCount / total) * 100;
    final latePercentage = (lateCount / total) * 100;
    final absentPercentage = (absentCount / total) * 100;

    return SizedBox(
      width: 150, // Specify the size for the pie chart
      height: 150,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0, // No space between the sections
          centerSpaceRadius: 60, // Larger center space
          startDegreeOffset: -90, // Start from the top
          sections: [
            PieChartSectionData(
              value: onTimePercentage,
              title: 'On Time',
              color: Colors.green,
              radius: 50, // Adjust radius for compact look
              showTitle: false, // Hide the title on each section
            ),
            PieChartSectionData(
              value: latePercentage,
              title: 'Late',
              color: Colors.red,
              radius: 45, // Slightly smaller radius for the late section
              showTitle: false,
            ),
            PieChartSectionData(
              value: absentPercentage,
              title: 'Absent',
              color: Colors.grey,
              radius: 40, // Even smaller radius for absent section
              showTitle: false,
            ),
          ],
          borderData: FlBorderData(show: false), // Remove the border
        ),
      ),
    );
  }
}
