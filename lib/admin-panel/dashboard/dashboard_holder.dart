import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sidebar_pages/employees.dart';
import 'sidebar_pages/shifts.dart';
import 'sidebar_pages/notifications.dart';
import 'sidebar_pages/settings.dart';
import '../dashboard/sidebar_pages/dashboard_page.dart';
import 'layout/responsive_layout.dart';
import '/controllers/menu_app_controllers.dart';

void main() {
  runApp(const AdminDashboard());
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance Management Dashboard',
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isExpanded = true;
  Widget? currentScreen;
  int selectedIndex = 0;
  final ValueNotifier<int> employeeCount = ValueNotifier<int>(0);
  int departmentCount = 0;
  int shiftCount = 0;
  final MenuAppController _menuController = MenuAppController();

  @override
  void initState() {
    super.initState();
    currentScreen = Dashboard(employeeCount: employeeCount);
    _loadCounts();
  }

  Future<void> _loadCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> employeeList = prefs.getStringList('employees') ?? [];
    employeeCount.value = employeeList.length;
  }

  @override
  void dispose() {
    employeeCount.dispose();
    super.dispose();
  }

  void _onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
      switch (index) {
        case 0:
          currentScreen = Dashboard(employeeCount: employeeCount);
          break;
        case 1:
          currentScreen = EmployeesScreen(
            onEmployeeCountChanged: (count) {
              employeeCount.value = count;
            },
          );
          break;
        case 2:
          currentScreen = const ShiftsScreen();
          break;
        case 3:
          currentScreen = const NotificationsScreen();
          break;
        case 4:
          currentScreen = const SettingsScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      employeeCount: employeeCount,
      departmentCount: departmentCount,
      shiftCount: shiftCount,
      currentScreen: currentScreen,
      selectedIndex: selectedIndex,
      onDestinationSelected: _onDestinationSelected,
      menuController: _menuController,
    );
  }
}
