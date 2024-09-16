// Define routes using GoRouter
import 'package:go_router/go_router.dart';
import 'package:kopiyka/constants/routing_enum.dart';
import 'package:kopiyka/screens/dashboard/dashboard_screen.dart';
import 'package:kopiyka/screens/not_found_screen.dart';
import 'package:kopiyka/screens/reports_screen.dart';
import 'package:kopiyka/screens/restore_data_screen.dart';
import 'package:kopiyka/screens/settings_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: "/" + RoutingEnum.reports.name,
      name: RoutingEnum.reports.name,
      builder: (context, state) => const ReportsScreen(), // Example screen
    ),
    GoRoute(
      path: "/" + RoutingEnum.restoreData.name,
      name: RoutingEnum.restoreData.name,
      builder: (context, state) => const RestoreDataScreen(), // Example screen
    ),
    GoRoute(
      path: "/" + RoutingEnum.settings.name,
      name: RoutingEnum.settings.name,
      builder: (context, state) => const SettingsScreen(), // Example screen
    )
  ],
  errorBuilder: (context, state) {
    return const NotFoundScreen(); // 404 page
  },
);
