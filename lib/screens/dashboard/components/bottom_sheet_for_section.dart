import 'package:flutter/material.dart';

class BottomSheetForSection extends StatelessWidget {
  final int index;
  final dynamic selectedData;
  final Function() onClose;

  const BottomSheetForSection({
    Key? key,
    required this.index,
    required this.selectedData,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color.fromARGB(26, 73, 63, 63),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Категория: ${selectedData.transactions.first.category.title}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Загальна сумма: \$${selectedData.transactions.fold(0, (sum, transaction) => sum + transaction.amount).toStringAsFixed(2)}',
          ),
          const SizedBox(),
          ...selectedData.transactions.map<Widget>((transaction) {
            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  title: Text(transaction.description),
                  subtitle:
                      Text('Сумма: \$${transaction.amount.toStringAsFixed(2)}'),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
