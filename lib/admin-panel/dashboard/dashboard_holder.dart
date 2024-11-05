import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sidebar_pages/employees.dart';
import '../dashboard/sidebar_pages/dashboard_page.dart';
import 'sidebar_pages/shifts.dart';
import 'sidebar_pages/notifications.dart';
import 'sidebar_pages/settings.dart';
import 'sidebar_pages/calendar.dart';
import '../login/login_page.dart';
import 'info_holder/summary_card.dart';
import 'package:face_recognition_design/responsiveness.dart';

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
  static const double cardWidth = 180;
  static const double cardHeight = 120;
  Widget? currentScreen;
  int selectedIndex = 0;
  final ValueNotifier<int> employeeCount = ValueNotifier<int>(0);
  int departmentCount = 0;
  int shiftCount = 0;

  @override
  void initState() {
    super.initState();
    currentScreen = const Dashboard();
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

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobileLayout(),
      tablet: _buildTabletLayout(),
      desktop: _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            backgroundColor: const Color.fromARGB(255, 216, 34, 34),
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white),
            selectedIconTheme: const IconThemeData(color: Colors.black),
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            leading: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isExpanded
                  ? Center(
                      child: Image.asset(
                        'lib/images/img/FDS_Icon.png',
                        width: 200,
                        height: 200,
                      ),
                    )
                  : Center(
                      child: Image.asset(
                        'lib/images/img/FDS_Icon.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
            ),
            destinations: [
              _buildDestination(Icons.home, "Dashboard"),
              _buildDestination(Icons.people, "Employees"),
              _buildDestination(Icons.schedule, "Shifts"),
              _buildDestination(Icons.calendar_today, "Calendar"),
              _buildDestination(Icons.notifications, "Notifications"),
              _buildDestination(Icons.settings, "Settings"),
              _buildDestination(Icons.logout, "Logout"),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
                switch (index) {
                  case 0:
                    currentScreen = const Dashboard();
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
                    currentScreen = const CalendarScreen();
                    break;
                  case 4:
                    currentScreen = const NotificationsScreen();
                    break;
                  case 5:
                    currentScreen = const SettingsScreen();
                    break;
                  case 6:
                    _showLogoutConfirmationDialog();
                    return;
                }
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        icon: const Icon(Icons.menu),
                      ),
                      const Text(
                        "Attendance Management",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: cardWidth / cardHeight,
                      children: [
                        SummaryCard(
                          title: "Departments",
                          count: departmentCount.toString(),
                          icon: Icons.business,
                        ),
                        SummaryCard(
                          title: "Shifts",
                          count: shiftCount.toString(),
                          icon: Icons.schedule,
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: employeeCount,
                          builder: (context, count, _) {
                            return SummaryCard(
                              title: "Employees",
                              count: count.toString(),
                              icon: Icons.people,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Flexible(
                    child: currentScreen ?? const CalendarScreen(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return _buildDesktopLayout(); // Adjust if needed
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Management"),
        backgroundColor: const Color.fromARGB(255, 216, 34, 34),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SummaryCard(
                  title: "Departments",
                  count: departmentCount.toString(),
                  icon: Icons.business,
                ),
                SummaryCard(
                  title: "Shifts",
                  count: shiftCount.toString(),
                  icon: Icons.schedule,
                ),
                ValueListenableBuilder<int>(
                  valueListenable: employeeCount,
                  builder: (context, count, _) {
                    return SummaryCard(
                      title: "Employees",
                      count: count.toString(),
                      icon: Icons.people,
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: currentScreen ?? const CalendarScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
            switch (index) {
              case 0:
                currentScreen = const Dashboard();
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
                currentScreen = const CalendarScreen();
                break;
              case 4:
                currentScreen = const NotificationsScreen();
                break;
              case 5:
                currentScreen = const SettingsScreen();
                break;
              case 6:
                _showLogoutConfirmationDialog();
                return;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Employees",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Shifts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Logout",
          ),
        ],
      ),
    );
  }

  NavigationRailDestination _buildDestination(IconData icon, String label) {
    return NavigationRailDestination(
      icon: Tooltip(
        message: isExpanded ? '' : label,
        child: Icon(icon),
      ),
      label: Text(label),
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
