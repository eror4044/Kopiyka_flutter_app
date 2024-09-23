import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kopiyka/app_routes.dart';
import 'package:kopiyka/generated/app_localizations.dart'; // Импорт локализаций

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(AppLocalizations.of(context)!.menu),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.dashboard),
            onTap: () {
              context.go(AppRoutes.dashboard);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.reports),
            onTap: () {
              context.go(AppRoutes.reports);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              context.go(AppRoutes.settings);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.restoreData),
            onTap: () {
              context.go(AppRoutes.restoreData);
            },
          )
        ],
      ),
    );
  }
}
