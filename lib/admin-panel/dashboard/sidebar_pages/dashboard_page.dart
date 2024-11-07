import 'package:flutter/material.dart';
import '../info_holder/pie_chart.dart';
import '../info_holder/summary_card.dart';
import '../sidebar_pages/calendar.dart';

class Dashboard extends StatelessWidget {
  final ValueNotifier<int> employeeCount; // Accept the ValueNotifier

  const Dashboard({Key? key, required this.employeeCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: employeeCount,
      builder: (context, count, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Responsive Info Cards
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 768
                        ? 3
                        : (constraints.maxWidth > 480 ? 2 : 1);

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount:
                          5, // Five items: 3 InfoCards + Calendar + PieChart
                      itemBuilder: (context, index) {
                        String cardTitle = '';
                        Widget cardContent = const SizedBox.shrink();

                        switch (index) {
                          case 0:
                            cardTitle = 'Employees';
                            cardContent = InfoCard(
                              title: cardTitle,
                              count: count,
                            );
                            break;
                          case 1:
                            cardTitle = 'Department';
                            cardContent = InfoCard(title: cardTitle);
                            break;
                          case 2:
                            cardTitle = 'Shift';
                            cardContent = InfoCard(title: cardTitle);
                            break;
                          case 3:
                            cardTitle = 'Calendar';
                            cardContent = const CalendarScreen();
                            break;
                          case 4:
                            cardTitle = 'Attendance Summary';
                            cardContent = const CustomPieChart(
                              onTimeCount: 8,
                              lateCount: 3,
                              absentCount: 2,
                            );
                            break;
                        }

                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: cardContent,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
