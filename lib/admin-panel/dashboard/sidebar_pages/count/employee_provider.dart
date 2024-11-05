import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeProvider with ChangeNotifier {
  List<List<String>> _employees = [];

  List<List<String>> get employees => _employees;

  int get employeeCount => _employees.length;

  Future<void> loadEmployees() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> employeeList = prefs.getStringList('employees') ?? [];
    _employees = employeeList.map((employee) => employee.split(',')).toList();
    notifyListeners();
  }

  Future<void> addEmployee(String employee) async {
    _employees.add(employee.split(','));
    await _updateSharedPreferences();
    notifyListeners(); // Notify listeners about the change
  }

  Future<void> removeEmployee(int index) async {
    if (index >= 0 && index < _employees.length) {
      _employees.removeAt(index);
      await _updateSharedPreferences();
      notifyListeners(); // Notify listeners about the change
    }
  }

  Future<void> _updateSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> employeeList =
        _employees.map((employee) => employee.join(',')).toList();
    await prefs.setStringList('employees', employeeList);
  }
}
