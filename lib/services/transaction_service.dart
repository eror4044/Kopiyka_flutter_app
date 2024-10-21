import 'package:kopiyka/models/category.dart';
import 'package:kopiyka/models/transaction.dart';

abstract class TransactionService {
  Future<List<Map<String, dynamic>>> getTransactions();
  Future<int> insertCategory(CategoryModel category);
  Future<int> insertTransaction(TransactionModel transaction);
}
