import 'package:flutter/material.dart';
import 'package:kopiyka/screens/add_transaction_screen.dart';

class DashboardBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            iconSize: 120,
            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTransactionScreen()),
              );
            },
          ),
          IconButton(
            iconSize: 120,
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTransactionScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
