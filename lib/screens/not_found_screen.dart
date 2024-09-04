import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart'; // Import for GoRouter

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '404 - Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Go back to the previous screen if available, or to the dashboard
                context.go('/');
              },
              child: const Text('Go Back to Home'),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
