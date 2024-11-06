import 'package:flutter/material.dart';
import '../confirmation/confirmation_dialog.dart';

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
          // Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.red, // Set the background color to red
            ),
            child: Center(
              child: SizedBox(
                width: 150,
                height: 100,
                child: Image.asset("lib/images/img/FDS_Icon.png",
                    fit: BoxFit.contain),
              ),
            ),
          ),
          // Other menu items
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
            title: "Notifications",
            icon: Icons.notifications,
            press: () => onDestinationSelected(3),
          ),
          DrawerListTile(
            title: "Settings",
            icon: Icons.settings,
            press: () => onDestinationSelected(4),
          ),
          // Logout item
          DrawerListTile(
            title: "Logout",
            icon: Icons.logout,
            press: () => showLogoutConfirmationDialog(
                context), // Call the logout function
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
