import 'package:flutter/material.dart';

// SideMenu widget that contains the sidebar navigation
class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
    required this.onDestinationSelected,
  }) : super(key: key);

  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Drawer Header with red background and resizable image
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.red, // Set the background color to red
            ),
            child: Center(
              child: SizedBox(
                width: 150, // Adjust width to resize the image
                height: 100, // Adjust height to resize the image
                child: Image.asset("lib/images/img/FDS_Icon.png",
                    fit: BoxFit.contain),
              ),
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: Icons.dashboard,
            press: () => onDestinationSelected(0),
          ),
          DrawerListTile(
            title: "Employees",
            icon: Icons.people,
            press: () => onDestinationSelected(1),
          ),
          DrawerListTile(
            title: "Shifts",
            icon: Icons.schedule,
            press: () => onDestinationSelected(2),
          ),
          DrawerListTile(
            title: "Calendar",
            icon: Icons.calendar_today,
            press: () => onDestinationSelected(3),
          ),
          DrawerListTile(
            title: "Notifications",
            icon: Icons.notifications,
            press: () => onDestinationSelected(4),
          ),
          DrawerListTile(
            title: "Settings",
            icon: Icons.settings,
            press: () => onDestinationSelected(5),
          ),
          DrawerListTile(
            title: "Logout",
            icon: Icons.logout,
            press: () => onDestinationSelected(6),
          ),
        ],
      ),
    );
  }
}

// DrawerListTile widget to build individual list tiles for the sidebar
class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 25,
      leading: Icon(
        icon,
        color: Colors.black,
        size: 20,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
