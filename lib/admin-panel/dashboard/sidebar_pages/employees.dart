import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeesScreen extends StatefulWidget {
  final ValueChanged<int> onEmployeeCountChanged;

  const EmployeesScreen({super.key, required this.onEmployeeCountChanged});

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

    setState(() {
      _employees = employeeList.map((employee) {
        return employee.split(',');
      }).toList();
      // Notify the count of employees
      widget.onEmployeeCountChanged(_employees.length);
    });
  }

  Future<void> _deleteEmployee(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove employee from the list
    _employees.removeAt(index);

    // Update the employee list in SharedPreferences
    List<String> employeeList = _employees.map((e) => e.join(',')).toList();
    await prefs.setStringList('employees', employeeList);

    // Notify the count of employees
    widget.onEmployeeCountChanged(_employees.length);

    // Reload the employees
    _loadEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              DataTable(
                headingRowColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.grey.shade200),
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Job Title')),
                  DataColumn(
                      label: Text('Actions')), // Column for delete action
                ],
                rows: _employees.asMap().entries.map((entry) {
                  int index = entry.key;
                  List<String> employee = entry.value;

                  String id = employee.length > 0 ? employee[0] : 'N/A';
                  String name = employee.length > 1 ? employee[1] : 'N/A';
                  String jobTitle = employee.length > 2 ? employee[2] : 'N/A';

                  return DataRow(cells: [
                    DataCell(Text(id)),
                    DataCell(Text(name)),
                    DataCell(Text(jobTitle)),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteConfirmationDialog(index);
                        },
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Employee"),
          content: const Text(
              "Are you sure you want to delete this employee? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteEmployee(index); // Proceed with deletion
              },
            ),
          ],
        );
      },
    );
  }
}
