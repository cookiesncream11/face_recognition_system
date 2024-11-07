import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Calendar",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 628, // Specified width
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                focusedDay: DateTime.now(),
                daysOfWeekHeight: 30, // Adjust if needed for readability
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false, // Hides the format button
                  leftChevronVisible: false, // Hides the previous month arrow
                  rightChevronVisible: false, // Hides the next month arrow
                ),
                calendarStyle: CalendarStyle(
                  cellMargin:
                      const EdgeInsets.all(2), // Reduce spacing between dates
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
