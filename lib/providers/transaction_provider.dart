import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:kopiyka/data/databases/heplers/database_helper.dart";
import "package:kopiyka/models/transaction.dart";
import "package:kopiyka/models/transaction_groped_data.dart";

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<TransactionGroupedData>>(
        (ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<List<TransactionGroupedData>> {
  TransactionNotifier() : super([]);

  Future<void> fetchTransactions() async {
    try {
      final transactions =
          await DatabaseHelper().getTransactionsWithCategories();
      state = transactions;
    } catch (e) {
      state = [];
      debugPrint('Error fetching transactions: $e');
    }
  }

  void addTransaction(TransactionModel transaction) async {
    //add transaction to the database and update the state
    await DatabaseHelper().insertTransaction(transaction);
    fetchTransactions();
  }
}
