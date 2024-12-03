import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kopiyka/app_routes.dart';
import 'package:kopiyka/providers/category_provider.dart';
import 'package:kopiyka/providers/transaction_provider.dart';
import 'package:kopiyka/screens/dashboard/components/bottom_bar.dart';
import 'package:kopiyka/screens/dashboard/components/custom_drawer.dart';
import 'package:kopiyka/screens/dashboard/components/dashboard_pie_chart.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(transactionProvider.notifier).fetchTransactions();
    ref.read(categoryProvider.notifier).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final transactionsByPeriod = ref.watch(transactionProvider);

    // Check if the state has periods available
    if (transactionsByPeriod.transactionsByPeriod.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.go(AppRoutes.settings);
            },
          ),
        ],
      ),
      body: PageView.builder(
        itemCount: transactionsByPeriod.periods.length,
        itemBuilder: (context, index) {
          final period = transactionsByPeriod.periods[index];
          final transactionsForPeriod =
              transactionsByPeriod.getTransactionsForPeriod(period);

          return SingleChildScrollView(
            child: Column(
              children: [
                if (transactionsForPeriod != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      period,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DashboardPieChart(
                    transactionsByCategory: transactionsForPeriod,
                  )
                ],
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
      drawer: const CustomDrawer(),
    );
  }
}
