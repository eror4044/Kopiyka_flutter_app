import 'package:kopiyka/models/category.dart';

class TransactionModel {
  final int? id;
  final CategoryModel category;
  final double amount;
  final String account;
  final String currency;
  final String description;
  final DateTime date;
  final bool isIncome;

  TransactionModel({
    this.id,
    required this.category,
    required this.amount,
    required this.account,
    required this.currency,
    required this.description,
    required this.date,
    required this.isIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category.id,
      'amount': amount,
      'account': account,
      'currency': currency,
      'description': description,
      'isIncome': isIncome ? 1 : 0,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(
      Map<String, dynamic> map, CategoryModel category) {
    return TransactionModel(
      id: map['id'],
      category: category,
      amount: map['amount'],
      account: map['account'],
      currency: map['currency'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      // Safely parse 'isIncome' from the map. Default to false if null.
      isIncome: (map['isIncome'] ?? 0) == 1,
    );
  }
}
