import 'package:flutter/material.dart';
import 'package:face_recognition_design/responsiveness.dart';
import '../sidebar_pages/sidebar.dart';
import '../sidebar_pages/calendar.dart';
import '../info_holder/summary_card.dart';
import '/controllers/menu_app_controllers.dart';
import '../sidebar_pages/dashboard_page.dart';

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
                  if (currentScreen is Dashboard)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                        physics: const NeverScrollableScrollPhysics(),
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

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      key: menuController.scaffoldKey,
      appBar: AppBar(
        title: const Text("Attendance Management"),
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
          if (currentScreen is Dashboard)
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
          if (currentScreen is Dashboard)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
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
            ),
          Flexible(
            child: currentScreen ?? const CalendarScreen(),
          ),
        ],
      ),
    );
  }
}
