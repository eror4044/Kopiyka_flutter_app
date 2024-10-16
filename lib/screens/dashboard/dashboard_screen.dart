import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kopiyka/app_routes.dart';
import 'package:kopiyka/providers/category_provider.dart';
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

//ToDo create logic for screen dashboard by periods from day to day
class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(transactionProvider.notifier).fetchTransactions();
    ref.read(categoryProvider.notifier).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            //open change theme screen
            context.go(AppRoutes.settings);
          },
        ),
      ]),
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
