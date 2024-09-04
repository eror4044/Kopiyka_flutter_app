import 'package:flutter/material.dart';
import 'package:kopiyka/screens/add_transaction_modal.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

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
              showAddTransactionModal(context, true);
            },
          ),
          IconButton(
            iconSize: 120,
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: () {
              showAddTransactionModal(context, false);
            },
          ),
        ],
      ),
    );
  }
}
