import 'package:flutter/material.dart';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Screen'),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
