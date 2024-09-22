import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kopiyka/providers/theme_provider.dart';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Light Theme'),
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
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
