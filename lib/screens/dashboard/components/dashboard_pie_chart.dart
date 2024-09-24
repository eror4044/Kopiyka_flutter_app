import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';
import 'package:kopiyka/screens/dashboard/components/bottom_sheet_for_section.dart';
import 'package:kopiyka/screens/dashboard/components/custom_badge.dart';
import 'package:kopiyka/shared/app_colors.dart';

class DashboardPieChart extends StatefulWidget {
  final List<TransactionGroupedData> transactions;

  const DashboardPieChart({super.key, required this.transactions});

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

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SizedBox(
            height: chartSpaceHeight,
            child: PieChart(
              PieChartData(
                sections: showingSections(widget.transactions),
                centerSpaceRadius: chartSize / 4,
                sectionsSpace: 0,
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      return;
                    }
                    setState(() {
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                    showBottomSheetForSection(touchedIndex);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<PieChartSectionData> showingSections(
      List<TransactionGroupedData> groupedData) {
    final filteredGroupedData = groupedData
        .map((group) {
          final filteredTransactions = group.transactions
              .where((transaction) => !transaction.isIncome)
              .toList();
          return TransactionGroupedData(
            categoryName: group.categoryName,
            transactions: filteredTransactions,
          );
        })
        .where((group) => group.transactions.isNotEmpty)
        .toList();

    return filteredGroupedData.asMap().entries.map((entry) {
      int index = entry.key;
      TransactionGroupedData data = entry.value;

      final totalAmount = data.transactions.fold<double>(
        0,
        (sum, transaction) => sum + transaction.amount,
      );

      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final category = data.transactions.first.category;

      return PieChartSectionData(
        color: Color(category.color),
        value: totalAmount,
        title:
            '${(totalAmount / filteredGroupedData.expand((data) => data.transactions).fold(0, (sum, transaction) => sum + transaction.amount) * 100).toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: CustomBadge(
          svgAsset: category.icon,
          size: widgetSize,
          borderColor: AppColors.contentColorBlack,
        ),
        badgePositionPercentageOffset: .98,
      );
    }).toList();
  }

  void showBottomSheetForSection(int index) {
    if (index < 0 || index >= widget.transactions.length) return;

    final selectedData = widget.transactions[index];

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
