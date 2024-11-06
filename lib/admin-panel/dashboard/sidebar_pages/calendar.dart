import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final BoxConstraints constraints;

  const CalendarWidget({Key? key, required this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
