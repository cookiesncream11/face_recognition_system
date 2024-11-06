import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../info_holder/pie_chart.dart';
import '../info_holder/summary_card.dart';

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
              mainAxisSize: MainAxisSize
                  .min, // Prevent the column from taking too much space
              children: [
                // Responsive Info Cards
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Determine the number of columns based on screen width
                    int crossAxisCount = constraints.maxWidth > 768
                        ? 3 // Show 3 cards in a row for larger screens
                        : (constraints.maxWidth > 480 ? 2 : 1);

                    return GridView.builder(
                      shrinkWrap: true, // Makes the GridView fit its content
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: 4, // Four cards, including the calendar
                      itemBuilder: (context, index) {
                        String cardTitle = '';
                        Widget cardContent =
                            const SizedBox.shrink(); // Default empty widget

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
                            cardContent = _buildCalendar(constraints);
                            break;
                        }

                        return cardContent;
                      },
                    );
                  },
                ),
                // Add space between InfoCard and PieChart
                const SizedBox(height: 80),
                // Custom PieChart
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: CustomPieChart(
                    onTimeCount: 8,
                    lateCount: 3,
                    absentCount: 2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCalendar(BoxConstraints constraints) {
    // Set the calendar size to be responsive, ideally 400x400 or adjusted based on the screen size
    double calendarSize = 400.0;
    if (constraints.maxWidth < 480) {
      calendarSize =
          constraints.maxWidth - 32; // Make it smaller on smaller screens
    } else if (constraints.maxWidth > 800) {
      // On larger screens (tablet/desktop), set a max width
      calendarSize = 600.0;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: calendarSize,
      height: calendarSize, // Set fixed height for calendar
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // We remove the Row with navigation buttons to keep the UI clean
          // Removed the IconButton row for navigation (previous and next months)

          // TableCalendar without custom navigation controls
          Expanded(
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              daysOfWeekHeight: 30, // Ensure enough space for the days
              headerStyle: HeaderStyle(
                formatButtonVisible: false, // Hides the format button
                leftChevronVisible:
                    false, // Hides the left chevron (previous month arrow)
                rightChevronVisible:
                    false, // Hides the right chevron (next month arrow)
              ),
              onPageChanged: (focusedDay) {
                // You can handle page change (e.g., log the month change or update UI)
              },
            ),
          ),
        ],
      ),
    );
  }
}
