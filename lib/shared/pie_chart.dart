import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Moneyby'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '10 Лип - 9 Сер',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            PieChart(
              PieChartData(
                sections: showingSections(),
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Баланс 22 319,00₴',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(10, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: 11,
            title: '11%',
            radius: 50,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: 1,
            title: '1%',
            radius: 50,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 12,
            title: '12%',
            radius: 50,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 9,
            title: '9%',
            radius: 50,
          );
        case 4:
          return PieChartSectionData(
            color: Colors.blue,
            value: 9,
            title: '9%',
            radius: 50,
          );
        case 5:
          return PieChartSectionData(
            color: Colors.indigo,
            value: 39,
            title: '39%',
            radius: 50,
          );
        case 6:
          return PieChartSectionData(
            color: Colors.purple,
            value: 16,
            title: '16%',
            radius: 50,
          );
        case 7:
          return PieChartSectionData(
            color: Colors.pink,
            value: 1,
            title: '1%',
            radius: 50,
          );
        case 8:
          return PieChartSectionData(
            color: Colors.teal,
            value: 1,
            title: '1%',
            radius: 50,
          );
        case 9:
          return PieChartSectionData(
            color: Colors.brown,
            value: 1,
            title: '1%',
            radius: 50,
          );
        default:
          return PieChartSectionData();
      }
    });
  }
}
