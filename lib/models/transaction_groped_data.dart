import 'package:kopiyka/models/transaction.dart';

class TransactionGroupedData {
  final String categoryName;
  final List<TransactionModel> transactions;

  TransactionGroupedData({
    required this.categoryName,
    required this.transactions,
  });
}

List<TransactionGroupedData> groupTransactionsByCategory(
    List<TransactionModel> transactions) {
  final Map<String, List<TransactionModel>> groupedData = {};

  for (var transaction in transactions) {
    final categoryName = transaction.category.title;

    groupedData.update(
      categoryName,
      (list) => list..add(transaction),
      ifAbsent: () => [transaction],
    );
  }

  return groupedData.entries.map((entry) {
    return TransactionGroupedData(
      categoryName: entry.key,
      transactions: entry.value,
    );
  }).toList();
}
