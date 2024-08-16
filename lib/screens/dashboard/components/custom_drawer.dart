import 'package:flutter/material.dart';
import 'package:kopiyka/screens/reports_screen.dart';
import 'package:kopiyka/screens/restore_data_screen.dart';
import 'package:kopiyka/screens/settings_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: const Text('Reports'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportsScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Restore Data'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestoreDataScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
