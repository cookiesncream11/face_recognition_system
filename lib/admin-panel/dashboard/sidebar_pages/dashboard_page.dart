import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../info_holder/pie_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<Dashboard> {
  int onTimeCount = 8;
  int lateCount = 3;
  int absentCount = 2;

  @override
  void initState() {
    super.initState();
    _loadEmployeeCount();
  }

  Future<void> _loadEmployeeCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> employeeList = prefs.getStringList('employees') ?? [];

    setState(() {
      // Update onTimeCount, lateCount, and absentCount based on actual data if needed.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 25,
          child: CustomPieChart(
            onTimeCount: onTimeCount,
            lateCount: lateCount,
            absentCount: absentCount,
          ),
        ),
        const Center(
          child: Text(
            'Center Widget',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
