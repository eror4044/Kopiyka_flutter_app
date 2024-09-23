import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kopiyka/generated/app_localizations.dart';
import 'package:kopiyka/providers/language_provider.dart';
import 'package:kopiyka/providers/theme_provider.dart';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final selectedLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.theme,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<ThemeMode>(
              title: Text(AppLocalizations.of(context)!.lightTheme),
              value: ThemeMode.light,
              groupValue: themeMode,
              onChanged: (mode) {
                ref.read(themeProvider.notifier).setLightMode();
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(AppLocalizations.of(context)!.darkTheme),
              value: ThemeMode.dark,
              groupValue: themeMode,
              onChanged: (mode) {
                ref.read(themeProvider.notifier).setDarkMode();
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(AppLocalizations.of(context)!.systemDefault),
              value: ThemeMode.system,
              groupValue: themeMode,
              onChanged: (mode) {
                ref.read(themeProvider.notifier).setSystemMode();
              },
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<Locale>(
              title: Text(AppLocalizations.of(context)!.english),
              value: const Locale('en'),
              groupValue: selectedLanguage,
              onChanged: (locale) {
                ref.read(languageProvider.notifier).state = locale!;
              },
            ),
            RadioListTile<Locale>(
              title: Text(AppLocalizations.of(context)!.ukrainian),
              value: const Locale('uk'),
              groupValue: selectedLanguage,
              onChanged: (locale) {
                ref.read(languageProvider.notifier).state = locale!;
              },
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
