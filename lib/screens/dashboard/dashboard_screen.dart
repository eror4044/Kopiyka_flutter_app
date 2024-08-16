import 'package:flutter/material.dart';
import 'package:kopiyka/data/databases/heplers/database_helper.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';
import 'package:kopiyka/screens/dashboard/components/balance.dart';
import 'package:kopiyka/screens/dashboard/components/bottom_bar.dart';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart';
import 'package:kopiyka/screens/dashboard/components/pie_chart.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<TransactionGroupedData> transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  //ToDo move this to bloc state management
  Future<void> _fetchTransactions() async {
    try {
      transactions = await DatabaseHelper().getTransactionsWithCategories();
      setState(() {});
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DashboardPieChart(transactions: transactions),
            DashboardBalance(transactions: transactions),
          ],
        ),
      ),
      bottomNavigationBar: DashboardBottomBar(),
      drawer: CustomDrawer(),
    );
  }
}
