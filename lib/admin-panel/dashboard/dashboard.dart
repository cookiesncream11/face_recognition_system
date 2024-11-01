import 'package:flutter/material.dart';
import 'sidebar_pages/employees.dart';
import 'sidebar_pages/department.dart';
import 'sidebar_pages/shifts.dart';
import 'sidebar_pages/notifications.dart';
import 'sidebar_pages/settings.dart';
import 'sidebar_pages/calendar.dart';
import '../login/login_page.dart';

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

  @override
  void initState() {
    super.initState();
    currentScreen = const CalendarScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            backgroundColor: const Color(0xFF250000),
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
                        width: 50, // Smaller size
                        height: 50,
                      ),
                    ),
            ),
            destinations: [
              _buildDestination(Icons.people, "Employees"),
              _buildDestination(Icons.business, "Departments"),
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
                    currentScreen = const EmployeesScreen();

                    break;
                  case 1:
                    currentScreen = const DepartmentsScreen();
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
                    return; // Exit to prevent setting currentScreen
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
                  // Permanent Info Cards
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: GridView.count(
                      crossAxisCount: 3, // 3 cards per row
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: cardWidth / cardHeight,
                      children: const [
                        _InfoCard(
                          title: "Departments",
                          count: "5",
                          icon: Icons.business,
                        ),
                        _InfoCard(
                          title: "Shifts",
                          count: "3",
                          icon: Icons.schedule,
                        ),
                        _InfoCard(
                          title: "Employees",
                          count: "20",
                          icon: Icons.people,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Show the currentScreen based on user selection
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

  NavigationRailDestination _buildDestination(IconData icon, String label) {
    return NavigationRailDestination(
      icon: Tooltip(
        message: isExpanded ? '' : label,
        child: Container(
          width: isExpanded ? 24 : 56,
          child: Icon(icon),
        ),
      ),
      label: isExpanded
          ? Text(label)
          : Container(
              width: 56, alignment: Alignment.center, child: Text(label)),
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Admin()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    Key? key,
    required this.title,
    required this.count,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: _DashboardPageState.cardWidth,
        height: _DashboardPageState.cardHeight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: _DashboardPageState.cardHeight * 0.3),
              const SizedBox(height: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                count,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
