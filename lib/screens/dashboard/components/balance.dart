import 'package:flutter/material.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';

class DashboardBalance extends StatelessWidget {
  final List<TransactionGroupedData> transactions;

  const DashboardBalance({Key? key, required this.transactions})
      : super(key: key);

  // Method to calculate balance
  double calculateBalance(List<TransactionGroupedData> transactions) {
    double income = 0;
    double expenses = 0;

    // Separate income and expenses for clearer logic
    for (var data in transactions) {
      for (var transaction in data.transactions) {
        if (transaction.isIncome) {
          income += transaction.amount;
        } else {
          expenses += transaction.amount;
        }
      }
    }

    // Return final balance (income - expenses)
    return income - expenses;
  }

  @override
  Widget build(BuildContext context) {
    final balance = calculateBalance(transactions);

    return Text(
      "Balance: $balance UAH",
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
