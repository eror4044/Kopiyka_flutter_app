import 'package:flutter/material.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';

class DashboardBalance extends StatelessWidget {
  final List<TransactionGroupedData> transactions;

  const DashboardBalance({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final balance = transactions
        .expand((data) => data.transactions)
        .fold<double>(0, (sum, transaction) => sum + transaction.amount);

    return Text(
      "Balance: $balance UAH",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
