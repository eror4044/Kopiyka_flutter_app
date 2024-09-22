import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kopiyka/providers/theme_provider.dart';
import 'package:kopiyka/providers/language_provider.dart';
import 'package:kopiyka/routes.dart';
import 'package:kopiyka/theme/app_theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: KopiykaApp(),
    ),
  );
}

class KopiykaApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(languageProvider);
    return MaterialApp.router(
      title: 'Kopiyka',
      themeMode: themeMode,
      supportedLocales: const [
        Locale('en', ''),
        Locale('uk', ''),
      ],
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
      locale: locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
