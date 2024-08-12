import 'package:flutter/material.dart';

class RestoreDataScreen extends StatefulWidget {
  @override
  _RestoreDataScreenState createState() => _RestoreDataScreenState();
}

class _RestoreDataScreenState extends State<RestoreDataScreen> {
  String _fileName = 'No file selected';
  List<Map<String, dynamic>> _transactions = [];

  Future<void> _pickFile() async {}

  void _restoreData() {
    // Restore data logic, e.g., save _transactions to local database
    // For simplicity, we just print the transactions here
    for (var transaction in _transactions) {
      print(transaction);
    }
    // Show a message to the user
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Data restored successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restore Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Select .bac File'),
            ),
            SizedBox(height: 20),
            Text(_fileName),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _transactions.isNotEmpty ? _restoreData : null,
              child: Text('Restore Data'),
            ),
          ],
        ),
      ),
    );
  }
}
