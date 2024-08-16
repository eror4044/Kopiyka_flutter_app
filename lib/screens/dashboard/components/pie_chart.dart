import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';
import 'package:kopiyka/screens/dashboard/components/custom_badge.dart';
import 'package:kopiyka/shared/app_colors.dart';

class DashboardPieChart extends StatelessWidget {
  final List<TransactionGroupedData> transactions;

  const DashboardPieChart({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PieChart(
        PieChartData(
          sections: showingSections(transactions),
          centerSpaceRadius: 60,
          sectionsSpace: 0,
        ),
      ),
    );
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
        badgeWidget: CustomBadge(
          svgAsset: category.icon,
          size: widgetSize,
          borderColor: AppColors.contentColorBlack,
        ),
        badgePositionPercentageOffset: .98,
      );
    }).toList();
  }
}
