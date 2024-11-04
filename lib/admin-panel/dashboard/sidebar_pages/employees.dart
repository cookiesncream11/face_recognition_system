import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  List<List<String>> _employees = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> employeeList = prefs.getStringList('employees') ?? [];

    // Convert employee data into a list of lists for the DataTable
    setState(() {
      _employees = employeeList.map((employee) {
        return employee.split(',');
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity, // Fill the available width
          padding: const EdgeInsets.all(16.0), // Optional padding
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2), // Box border
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Job Title')),
            ],
            rows: _employees.map((employee) {
              // Check the length of employee data to avoid out-of-range error
              String id = employee.length > 0 ? employee[0] : 'N/A';
              String name = employee.length > 1 ? employee[1] : 'N/A';
              String jobTitle = employee.length > 2 ? employee[2] : 'N/A';

              return DataRow(cells: [
                DataCell(Text(id)), // ID
                DataCell(Text(name)), // Name
                DataCell(Text(jobTitle)), // Job Title
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
