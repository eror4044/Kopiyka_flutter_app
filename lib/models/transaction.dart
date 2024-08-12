class Transaction {
  final String id;
  final double amount;
  final String category;
  final DateTime date;

  Transaction(
      {required this.id,
      required this.amount,
      required this.category,
      required this.date});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'],
      category: json['category'],
      date: json['date'],
    );
  }
}
