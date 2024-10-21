import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kopiyka/generated/app_localizations.dart';
import 'package:kopiyka/providers/theme_provider.dart';
import 'package:kopiyka/providers/language_provider.dart';
import 'package:kopiyka/routes.dart';
import 'package:kopiyka/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: KopiykaApp(),
    ),
  );
}

//just a test function to add data to firestore
void addTestData() async {
  await FirebaseFirestore.instance.collection('test').add({
    'name': 'Flutter',
    'description': 'Firebase test',
  });
}

class KopiykaApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(languageProvider);
    addTestData();
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
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
