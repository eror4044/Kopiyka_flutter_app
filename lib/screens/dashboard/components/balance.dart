import 'package:flutter/material.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';

class DashboardBalance extends StatelessWidget {
  final List<TransactionGroupedByCategoryData> transactionsByCategory;

  const DashboardBalance({Key? key, required this.transactionsByCategory})
      : super(key: key);

  // Method to calculate the total balance
  double calculateBalance(List<TransactionGroupedByCategoryData> data) {
    double income = 0;
    double expenses = 0;

    for (var categoryData in data) {
      for (var transaction in categoryData.transactions) {
        if (transaction.isIncome) {
          income += transaction.amount;
        } else {
          expenses += transaction.amount;
        }
      }
    }

    return income - expenses;
  }

  @override
  Widget build(BuildContext context) {
    final balance = calculateBalance(transactionsByCategory);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Balance: $balance USD',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
