import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login/login_page.dart';

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog when the user clicks "Cancel"
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Clear shared preferences
              SharedPreferences prefs = await SharedPreferences.getInstance();

              bool removedUsername = await prefs.remove('username');
              bool removedPassword = await prefs.remove('password');

              // Debugging print statements
              print('Username removed: $removedUsername');
              print('Password removed: $removedPassword');

              // Close the dialog first before navigating
              Navigator.of(dialogContext).pop();

              // Proceed with navigation after logout
              if (removedUsername && removedPassword) {
                // Use context from the main widget to push replacement
                Navigator.pushReplacement(
                  context, // Use the main context here for navigation
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                // Show an error if shared preferences removal failed
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Failed to log out. Try again.')),
                );
              }
            },
            child: const Text('Log Out'),
          ),
        ],
      );
    },
  );
}
