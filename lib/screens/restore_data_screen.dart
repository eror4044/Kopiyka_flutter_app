import 'package:flutter/material.dart';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart';

class RestoreDataScreen extends StatefulWidget {
  const RestoreDataScreen({super.key});

  @override
  _RestoreDataScreenState createState() => _RestoreDataScreenState();
}

class _RestoreDataScreenState extends State<RestoreDataScreen> {
  String _fileName = 'No file selected';
  List<Map<String, dynamic>> _transactions = [];

  Future<void> _pickFile() async {}

  void _restoreData() {
    // Show a message to the user
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data restored successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restore Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Select .bac File'),
            ),
            const SizedBox(height: 20),
            Text(_fileName),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _transactions.isNotEmpty ? _restoreData : null,
              child: const Text('Restore Data'),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
