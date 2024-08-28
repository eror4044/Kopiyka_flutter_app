import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kopiyka/data/databases/heplers/database_helper.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';
import 'package:kopiyka/providers/transaction_provider.dart';
import 'package:kopiyka/screens/dashboard/components/balance.dart';
import 'package:kopiyka/screens/dashboard/components/bottom_bar.dart';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart';
import 'package:kopiyka/screens/dashboard/components/dashboard_pie_chart.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  List<TransactionGroupedData> transactions = [];

  @override
  void initState() {
    super.initState();
    ref.read(transactionProvider.notifier).fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionProvider);

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
      bottomNavigationBar: const BottomBar(),
      drawer: const CustomDrawer(),
    );
  }
}
