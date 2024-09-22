// Define routes using GoRouter
import 'package:go_router/go_router.dart';
import 'package:kopiyka/app_routes.dart';
import 'package:kopiyka/screens/dashboard/dashboard_screen.dart';
import 'package:kopiyka/screens/not_found_screen.dart';
import 'package:kopiyka/screens/reports_screen.dart';
import 'package:kopiyka/screens/restore_data_screen.dart';
import 'package:kopiyka/screens/settings_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.reports,
      name: 'reports',
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      path: AppRoutes.restoreData,
      name: 'restore-data',
      builder: (context, state) => const RestoreDataScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    )
  ],
  errorBuilder: (context, state) {
    return const NotFoundScreen(); // 404 page
  },
);
