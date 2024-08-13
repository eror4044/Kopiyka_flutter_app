import 'package:kopiyka/models/category.dart';

class TransactionModel {
  final int? id;
  final CategoryModel category;
  final double amount;
  final String account;
  final String currency;
  final String description;
  final DateTime date;

  TransactionModel({
    this.id,
    required this.category,
    required this.amount,
    required this.account,
    required this.currency,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category.id,
      'amount': amount,
      'account': account,
      'currency': currency,
      'description': description,
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
    );
  }
}
