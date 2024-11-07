import 'package:flutter/material.dart';
import 'package:face_recognition_design/responsiveness.dart';
import '../sidebar_pages/sidebar.dart';
import '../sidebar_pages/calendar.dart';
import '/controllers/menu_app_controllers.dart';

class ResponsiveLayout extends StatelessWidget {
  final ValueNotifier<int> employeeCount;
  final int departmentCount;
  final int shiftCount;
  final Widget? currentScreen;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final MenuAppController menuController;

  const ResponsiveLayout({
    Key? key,
    required this.employeeCount,
    required this.departmentCount,
    required this.shiftCount,
    required this.currentScreen,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.menuController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobileLayout(context),
      tablet: _buildTabletLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 1,
              child: SideMenu(
                onDestinationSelected: onDestinationSelected,
              ),
            ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Attendance Management",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                  // Remove SummaryCard here
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

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      key: menuController.scaffoldKey,
      appBar: AppBar(
        title: const Text("Dash"),
        backgroundColor: const Color.fromARGB(255, 216, 34, 34),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: menuController.controlMenu,
        ),
      ),
      drawer: SideMenu(
        onDestinationSelected: onDestinationSelected,
      ),
      body: Column(
        children: [
          // Remove SummaryCard here
          Flexible(
            child: currentScreen ?? const CalendarScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      key: menuController.scaffoldKey,
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: const Color.fromARGB(255, 216, 34, 34),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: menuController.controlMenu,
        ),
      ),
      drawer: SideMenu(
        onDestinationSelected: onDestinationSelected,
      ),
      body: Column(
        children: [
          Flexible(
            child: currentScreen ?? const CalendarScreen(),
          ),
        ],
      ),
    );
  }
}
