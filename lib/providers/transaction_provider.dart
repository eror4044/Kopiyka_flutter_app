import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kopiyka/data/databases/heplers/database_helper.dart';
import 'package:kopiyka/models/transaction.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, TransactionsByPeriod>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<TransactionsByPeriod> {
  TransactionNotifier() : super(TransactionsByPeriod({}));

  Future<void> fetchTransactions({int startDay = 5}) async {
    try {
      final transactions =
          await DatabaseHelper().getTransactionsWithCategories();

      final groupedTransactions =
          _groupTransactionsByCustomPeriod(transactions, startDay);

      state = groupedTransactions;
    } catch (e) {
      state = TransactionsByPeriod({});
      debugPrint('Error fetching transactions: $e');
    }
  }

  void addTransaction(TransactionModel transaction) async {
    await DatabaseHelper().insertTransaction(transaction);
    fetchTransactions();
  }

  TransactionsByPeriod _groupTransactionsByCustomPeriod(
      List<TransactionGroupedByCategoryData> transactionsGroupedByCategory,
      int startDay) {
    final Map<String, List<TransactionGroupedByCategoryData>> groupedByDate =
        {};

    for (var groupedCategoryData in transactionsGroupedByCategory) {
      for (var transaction in groupedCategoryData.transactions) {
        final DateTime transactionDate = transaction.date;

        // Determine the start and end dates of the custom period
        DateTime periodStartDate =
            _getCustomPeriodStart(transactionDate, startDay);
        DateTime periodEndDate = _getCustomPeriodEnd(transactionDate, startDay);

        // Create a period key based on the start and end dates
        String periodKey =
            '${DateFormat('d MMMM').format(periodStartDate)} - ${DateFormat('d MMMM').format(periodEndDate)}';

        // Find or create the list of TransactionGroupedByCategoryData for this period
        final periodCategories = groupedByDate.putIfAbsent(periodKey, () => []);

        // Check if there's already a category with the same name in this period
        final categoryTitle = groupedCategoryData.categoryName;
        final categoryData = periodCategories.firstWhere(
          (existingCategoryData) =>
              existingCategoryData.categoryName == categoryTitle,
          orElse: () {
            // If not found, create a new one and add it to the periodCategories list
            final newCategoryData = TransactionGroupedByCategoryData(
              categoryName: categoryTitle,
              transactions: [],
            );
            periodCategories.add(newCategoryData);
            return newCategoryData;
          },
        );

        // Add the transaction to the appropriate category's list within the period
        categoryData.transactions.add(transaction);
      }
    }

    // Convert the grouped data to TransactionsByPeriod and sort by date
    final sortedGroupedByDate = Map.fromEntries(groupedByDate.entries.toList()
      ..sort((a, b) {
        // Parse period start dates to sort
        final DateTime aStartDate =
            DateFormat('d MMMM').parse(a.key.split(' - ')[0]);
        final DateTime bStartDate =
            DateFormat('d MMMM').parse(b.key.split(' - ')[0]);

        // Sort in descending order (most recent first)
        return bStartDate.compareTo(aStartDate);
      }));

    // Return the grouped data as TransactionsByPeriod
    return TransactionsByPeriod(sortedGroupedByDate);
  }

  DateTime _getCustomPeriodStart(DateTime date, int customStartDay) {
    if (date.day >= customStartDay) {
      return DateTime(date.year, date.month, customStartDay);
    } else {
      return DateTime(date.year, date.month - 1, customStartDay);
    }
  }

  DateTime _getCustomPeriodEnd(DateTime date, int customStartDay) {
    DateTime startOfNextPeriod =
        _getCustomPeriodStart(date.add(Duration(days: 30)), customStartDay);
    return startOfNextPeriod.subtract(Duration(days: 1));
  }
}
