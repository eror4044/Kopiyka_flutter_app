import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kopiyka/providers/theme_provider.dart';
import 'package:kopiyka/routes.dart';
import 'package:kopiyka/theme/app_theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Flutter Theme Example',
      themeMode: themeMode,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
