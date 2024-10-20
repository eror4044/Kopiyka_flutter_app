import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';
import 'package:kopiyka/screens/dashboard/components/bottom_sheet_for_section.dart';
import 'package:kopiyka/screens/dashboard/components/custom_badge.dart';
import 'package:kopiyka/shared/app_colors.dart';

class DashboardPieChart extends StatefulWidget {
  final List<TransactionGroupedByCategoryData> transactionsByCategory;

  const DashboardPieChart({super.key, required this.transactionsByCategory});

  @override
  _DashboardPieChartState createState() => _DashboardPieChartState();
}

class _DashboardPieChartState extends State<DashboardPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        final chartSize = screenWidth * 0.6;
        final chartSpaceHeight = screenHeight * 0.63;

        // Calculate total balance and total spent
        final double totalIncome = widget.transactionsByCategory
            .expand((data) => data.transactions)
            .where((transaction) => transaction.isIncome)
            .fold(0.0, (sum, transaction) => sum + transaction.amount);

        final double totalSpent = widget.transactionsByCategory
            .expand((data) => data.transactions)
            .where((transaction) => !transaction.isIncome)
            .fold(0.0, (sum, transaction) => sum + transaction.amount);

        final double totalBalance = totalIncome - totalSpent;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: chartSpaceHeight,
                child: PieChart(
                  PieChartData(
                    sections: _showingSections(widget.transactionsByCategory),
                    centerSpaceRadius: chartSize / 3.5,
                    sectionsSpace: 0,
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        if (event is! FlLongPressEnd ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          return;
                        }
                        setState(() {
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                        _showBottomSheetForSection(touchedIndex);
                      },
                    ),
                  ),
                ),
              ),
              // Center balance information
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    totalBalance.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    totalSpent.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _showingSections(
      List<TransactionGroupedByCategoryData> groupedData) {
    // Filter out categories that are of type 'expense'
    final filteredGroupedData = groupedData
        .where((data) => data.transactions.first.category.type != 'expense')
        .toList();

    final double totalAmount =
        filteredGroupedData.fold<double>(0.0, (sum, data) {
      return sum +
          data.transactions.fold(0.0, (sum, transaction) {
            return sum + transaction.amount;
          });
    });

    return filteredGroupedData.asMap().entries.map((entry) {
      int index = entry.key;
      TransactionGroupedByCategoryData data = entry.value;

      final double categoryTotal = data.transactions.fold<double>(
        0.0,
        (sum, transaction) => sum + transaction.amount,
      );

      final bool isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 20.0 : 16.0;
      final double radius = isTouched ? 110.0 : 100.0;
      final double widgetSize = isTouched ? 55.0 : 40.0;

      final color = Color(entry.value.transactions.first.category.color);
      final categoryIcon = data.transactions.first.category.icon;

      return PieChartSectionData(
        color: color,
        value: categoryTotal,
        title: '${(categoryTotal / totalAmount * 100).toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
        badgeWidget: CustomBadge(
          svgAsset: categoryIcon,
          size: widgetSize,
          borderColor: AppColors.contentColorBlack,
        ),
        badgePositionPercentageOffset: .98,
      );
    }).toList();
  }

  void _showBottomSheetForSection(int index) {
    if (index < 0 || index >= widget.transactionsByCategory.length) return;

    final selectedData = widget.transactionsByCategory[index];

    showModalBottomSheet(
      context: context,
      builder: (innerContext) {
        return BottomSheetForSection(
          index: index,
          selectedData: selectedData,
          onClose: () {
            setState(() {
              touchedIndex = -1;
            });
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        touchedIndex = -1;
      });
    });
  }
}
