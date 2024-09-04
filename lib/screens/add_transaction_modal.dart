import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kopiyka/models/category.dart';
import 'package:kopiyka/models/transaction.dart';
import 'package:kopiyka/providers/category_provider.dart';
import 'package:kopiyka/providers/transaction_provider.dart';
import 'package:kopiyka/screens/dashboard/components/custom_badge.dart';

class AddTransactionModal extends ConsumerStatefulWidget {
  final bool isIncome;
  const AddTransactionModal(this.isIncome, {super.key});

  @override
  _AddTransactionModalState createState() => _AddTransactionModalState();
}

class _AddTransactionModalState extends ConsumerState<AddTransactionModal> {
  String? _description;
  double? _amount;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _amount = double.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Select Category'),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                //showing only categories for income or expense
                itemCount: categories
                    .where((category) => widget.isIncome
                        ? category.type == CategoryType.income
                        : category.type == CategoryType.expense)
                    .length,
                itemBuilder: (context, index) {
                  final category = categories
                      .where((category) => widget.isIncome
                          ? category.type == CategoryType.income
                          : category.type == CategoryType.expense)
                      .toList()[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedCategory == category
                            ? Colors.grey.shade300
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: CustomBadge(
                        svgAsset: category.icon,
                        size: 55,
                        borderColor: Color(category.color),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_amount != null && _selectedCategory != null) {
                    TransactionModel transaction = TransactionModel(
                      amount: _amount!,
                      category: _selectedCategory!,
                      date: DateTime.now(),
                      account: '',
                      currency: '',
                      description: _description ?? '',
                      isIncome: widget.isIncome,
                    );
                    ref
                        .read(transactionProvider.notifier)
                        .addTransaction(transaction);
                    Navigator.pop(context);
                  } else {
                    // Show an error or message asking to provide both amount and category
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Please provide both amount and category')),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showAddTransactionModal(BuildContext context, bool isIncome) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return AddTransactionModal(isIncome);
    },
  );
}
