import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kopiyka/screens/not_found_screen.dart';
import 'package:kopiyka/screens/reports_screen.dart';
import 'package:kopiyka/screens/restore_data_screen.dart';
import 'package:kopiyka/screens/settings_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';

void main() {
  runApp(ProviderScope(child: KopiykaApp()));
}

class KopiykaApp extends StatelessWidget {
  KopiykaApp({Key? key}) : super(key: key);

  // Define routes using GoRouter
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/reports',
        name: 'reports',
        builder: (context, state) => ReportsScreen(), // Example screen
      ),
      GoRoute(
        path: '/restore-data',
        name: 'restore-data',
        builder: (context, state) => RestoreDataScreen(), // Example screen
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => SettingsScreen(), // Example screen
      )
    ],
    errorBuilder: (context, state) {
      return const NotFoundScreen(); // 404 page
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kopiyka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
