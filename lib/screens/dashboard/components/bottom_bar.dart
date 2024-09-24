import 'package:flutter/material.dart';
import 'package:kopiyka/screens/add_transaction_modal.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final iconSize = screenWidth * 0.35;

        return BottomAppBar(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: iconSize,
                  icon:
                      const Icon(Icons.add_circle_outline, color: Colors.green),
                  onPressed: () {
                    showAddTransactionModal(context, true);
                  },
                ),
                IconButton(
                  iconSize: iconSize,
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Colors.red),
                  onPressed: () {
                    showAddTransactionModal(context, false);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
