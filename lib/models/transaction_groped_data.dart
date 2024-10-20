import 'package:kopiyka/models/transaction.dart';

class TransactionsByPeriod {
  final Map<String, List<TransactionGroupedByCategoryData>>
      transactionsByPeriod;

  TransactionsByPeriod(this.transactionsByPeriod);

  // Optional method to get all period keys (for easier access and iteration)
  List<String> get periods => transactionsByPeriod.keys.toList();

  // Optional method to get transactions by a specific period
  List<TransactionGroupedByCategoryData>? getTransactionsForPeriod(
      String period) {
    return transactionsByPeriod[period];
  }
}

class TransactionGroupedByCategoryData {
  final String categoryName;
  final List<TransactionModel> transactions;

  TransactionGroupedByCategoryData({
    required this.categoryName,
    required this.transactions,
  });
}
