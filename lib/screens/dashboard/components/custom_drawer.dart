import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Reports'),
            onTap: () {
              // Navigate to the ReportsScreen
              context.go('/reports');
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              // Navigate to the SettingsScreen
              context.go('/settings');
            },
          ),
          ListTile(
            title: const Text('Restore Data'),
            onTap: () {
              // Navigate to the RestoreDataScreen
              context.go('/restore-data');
            },
          ),
          ListTile(
            title: const Text('404 Test route'),
            onTap: () {
              // Navigate to the empty screen
              context.go('/void');
            },
          )
        ],
      ),
    );
  }
}
