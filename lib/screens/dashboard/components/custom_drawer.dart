import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kopiyka/app_routes.dart';

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
            title: const Text('Dashboard'),
            onTap: () {
              context.go(AppRoutes.dashboard);
            },
          ),
          ListTile(
            title: const Text('Reports'),
            onTap: () {
              context.go(AppRoutes.reports);
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              context.go(AppRoutes.settings);
            },
          ),
          ListTile(
            title: const Text('Restore Data'),
            onTap: () {
              context.go(AppRoutes.restoreData);
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
