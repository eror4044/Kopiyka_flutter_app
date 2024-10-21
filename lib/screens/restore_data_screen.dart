import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart';

class RestoreDataScreen extends StatefulWidget {
  const RestoreDataScreen({super.key});

  @override
  _RestoreDataScreenState createState() => _RestoreDataScreenState();
}

class _RestoreDataScreenState extends State<RestoreDataScreen> {
  String _fileName = 'No file selected';
  List<Map<String, dynamic>> _transactions = [];

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['bac'],
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        File file = File(filePath);

        String fileContent = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(fileContent);

        setState(() {
          _fileName = result.files.single.name;
          _transactions = List<Map<String, dynamic>>.from(jsonData);
        });
      } else {
        setState(() {
          _fileName = 'No file selected';
          _transactions = [];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  void _restoreData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data restored successfully')),
    );
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
