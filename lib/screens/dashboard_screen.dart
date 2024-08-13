import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kopiyka/data/databases/heplers/database_helper.dart';
import 'package:kopiyka/models/category.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';
import 'package:kopiyka/shared/app_colors.dart';
import 'add_transaction_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'restore_data_screen.dart';
import '../services/privatbank_service.dart';
import '../services/monobank_service.dart';
import '../models/transaction.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dbHelper = DatabaseHelper();

  final PrivateBankService privatBankService =
      PrivateBankService('YOUR_PRIVATBANK_API_KEY');
  final MonobankService monobankService =
      MonobankService('YOUR_MONOBANK_API_KEY');
  List<TransactionGroupedData> transactions = [];
  int touchedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    _fetchTransactions();
  }

  void _initializeDatabase() async {
    await dbHelper.database; // init Database
  }

  Future<void> _fetchTransactions() async {
    try {
      transactions = await dbHelper.getTransactionsWithCategories();
      setState(() {});
    } catch (e) {
      debugPrint('debug: $e');
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
            SizedBox(
              height: 500,
              child: PieChart(
                PieChartData(
                  sections: showingSections(transactions),
                  centerSpaceRadius: 60,
                  sectionsSpace: 0,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Reports'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportsScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Restore Data'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RestoreDataScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<PieChartSectionData> showingSections(
    List<TransactionGroupedData> groupedData) {
  return groupedData.map((data) {
    final totalAmount = data.transactions.fold<double>(
      0,
      (sum, transaction) => sum + transaction.amount,
    );

    final isTouched = groupedData.indexOf(data) == 0;
    final fontSize = isTouched ? 20.0 : 16.0;
    final radius = isTouched ? 110.0 : 100.0;
    final widgetSize = isTouched ? 55.0 : 40.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    final category = data.transactions.first.category;

    return PieChartSectionData(
      color: Color(category.color),
      value: totalAmount,
      title:
          '${(totalAmount / groupedData.expand((data) => data.transactions).fold(0, (sum, transaction) => sum + transaction.amount) * 100).toStringAsFixed(1)}%',
      radius: radius,
      titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff),
        shadows: shadows,
      ),
      badgeWidget: _Badge(
        category.icon,
        size: widgetSize,
        borderColor: AppColors.contentColorBlack,
      ),
      badgePositionPercentageOffset: .98,
    );
  }).toList();
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'fastfood':
        return Icons.fastfood;
      case 'directions_car':
        return Icons.directions_car;
      case 'local_movies':
        return Icons.local_movies;
      case 'build':
        return Icons.build;
      case 'healing':
        return Icons.healing;
      case 'school':
        return Icons.school;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'home':
        return Icons.home;
      case 'savings':
        return Icons
            .savings; // Custom Icons.savings, if you use flutter 3.7 or higher
      default:
        return Icons.help; // Fallback icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Icon(
        getIconData(svgAsset),
        size: size * 0.6,
        color: borderColor,
      ),
    );
  }
}
