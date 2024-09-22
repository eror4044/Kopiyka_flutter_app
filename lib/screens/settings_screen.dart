import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kopiyka/providers/language_provider.dart';
import 'package:kopiyka/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final selectedLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
          //title: const Text(AppLocalizations.of(context)!.lightTheme),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<ThemeMode>(
              //title: Text(AppLocalizations.of(context)!.lightTheme),
              value: ThemeMode.light,
              groupValue: themeMode,
              onChanged: (mode) {
                ref.read(themeProvider.notifier).setLightMode();
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark Theme'),
              value: ThemeMode.dark,
              groupValue: themeMode,
              onChanged: (mode) {
                ref.read(themeProvider.notifier).setDarkMode();
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('System Default'),
              value: ThemeMode.system,
              groupValue: themeMode,
              onChanged: (mode) {
                ref.read(themeProvider.notifier).setSystemMode();
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Language Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<Locale>(
              title: const Text('English'),
              value: const Locale('en'),
              groupValue: selectedLanguage,
              onChanged: (locale) {
                ref.read(languageProvider.notifier).state = locale!;
              },
            ),
            RadioListTile<Locale>(
              title: const Text('Ukrainian'),
              value: const Locale('uk'),
              groupValue: selectedLanguage,
              onChanged: (locale) {
                ref.read(languageProvider.notifier).state = locale!;
              },
            ),
          ],
        ),
      ),
    );
  }
}
