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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();

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

  Future<void> _addEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = _nameController.text;
    String jobTitle = _jobTitleController.text;

    if (name.isNotEmpty && jobTitle.isNotEmpty) {
      // Create a new employee entry
      String newEmployee = '${_employees.length + 1},$name,$jobTitle';
      _employees.add(newEmployee.split(','));

      // Save the updated list
      List<String> employeeList = _employees.map((e) => e.join(',')).toList();
      await prefs.setStringList('employees', employeeList);

      // Clear input fields
      _nameController.clear();
      _jobTitleController.clear();

      // Notify the count of employees
      widget.onEmployeeCountChanged(_employees.length);

      // Reload employees
      _loadEmployees();
    }
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
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: _jobTitleController,
                decoration: const InputDecoration(
                  labelText: 'Job Title',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addEmployee,
                child: const Text('Add Employee'),
              ),
              const SizedBox(height: 20),
              DataTable(
                headingRowColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.grey.shade200),
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Job Title')),
                ],
                rows: _employees.map((employee) {
                  String id = employee.length > 0 ? employee[0] : 'N/A';
                  String name = employee.length > 1 ? employee[1] : 'N/A';
                  String jobTitle = employee.length > 2 ? employee[2] : 'N/A';

                  return DataRow(cells: [
                    DataCell(Text(id)),
                    DataCell(Text(name)),
                    DataCell(Text(jobTitle)),
                  ]);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
