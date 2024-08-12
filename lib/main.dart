import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(KopiykaApp());
}

class KopiykaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kopiyka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}
