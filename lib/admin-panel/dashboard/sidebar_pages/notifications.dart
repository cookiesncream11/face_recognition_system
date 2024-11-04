import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notifications = prefs.getStringList('notifications') ?? [];
    });
  }

  Future<void> _acceptEmployee(String notification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Extract employee data from the notification
    String employeeData = notification.split(': ').last; // Extracts data

    // Load the pending employees and employees list
    List<String> pendingList = prefs.getStringList('pending_employees') ?? [];
    List<String> employeeList = prefs.getStringList('employees') ?? [];

    // Check if the employee data is in the pending list
    if (pendingList.contains(employeeData)) {
      pendingList.remove(employeeData); // Remove from pending list
      employeeList
          .add('${employeeList.length + 1},$employeeData'); // Add with new ID

      // Update SharedPreferences
      await prefs.setStringList('pending_employees', pendingList);
      await prefs.setStringList('employees', employeeList);

      // Remove the notification
      setState(() {
        _notifications.remove(notification);
        prefs.setStringList('notifications', _notifications);
      });

      // Show a Snackbar for confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Employee approved: $employeeData')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error: Employee not found in pending list.')),
      );
    }
  }

  Future<void> _rejectEmployee(String notification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Extract the employee data from the notification
    String employeeData = notification.split(': ').last; // Extracts data

    // Load the pending employees list
    List<String> pendingList = prefs.getStringList('pending_employees') ?? [];

    // Check if the employee data is in the pending list
    if (pendingList.contains(employeeData)) {
      pendingList.remove(employeeData); // Remove from pending list

      // Update SharedPreferences
      await prefs.setStringList('pending_employees', pendingList);

      // Remove the notification
      setState(() {
        _notifications.remove(notification);
        prefs.setStringList('notifications', _notifications);
      });

      // Show a Snackbar for confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Employee rejected: $employeeData')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: _notifications.isEmpty
          ? const Center(child: Text("No notifications"))
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                String notification = _notifications[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(notification),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => _acceptEmployee(notification),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => _rejectEmployee(notification),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
