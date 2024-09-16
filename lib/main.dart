import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kopiyka/routes.dart';

void main() {
  runApp(ProviderScope(child: KopiykaApp()));
}

class KopiykaApp extends StatelessWidget {
  KopiykaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Kopiyka',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[200],
        ),
        routerConfig: router);
  }
}
