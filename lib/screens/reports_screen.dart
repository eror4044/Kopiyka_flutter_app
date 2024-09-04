import 'package:flutter/material.dart';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: const Center(
        child: Text('Reports Screen'),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
