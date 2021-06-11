import '/widgets/chart_bar.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  // const Chart({Key? key}) : super(key: key);
  final List<Expense> recentExpense;

  Chart(this.recentExpense);
  List<Map<String, Object>> get grpdExpenses {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        //weekday=DateTime.now()-index
        Duration(days: index), // DateTime today = DateTime.now();
        // DateTime fiftyDaysAgo = today.subtract(const Duration(days: 50));
      );
      var totalSum = 0.0;
      for (int i = 0; i < recentExpense.length; i++) {
        if (recentExpense[i].date.day == weekDay.day &&
            recentExpense[i].date.month == weekDay.month &&
            recentExpense[i].date.year == weekDay.year) {
          totalSum += recentExpense[i].amt;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        'DAY': DateFormat.E().format(weekDay).substring(0),
        'amt': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return grpdExpenses.fold(0.0, (sum, element) {
      return sum + (element['amt'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: (grpdExpenses as List<Map<String, Object>>).map((data) {
            return Expanded(
              child: ChartBar(
                data['DAY'].toString(),
                data['amt'] as double,
                totalSpending == 0.0
                    ? 0.0
                    : ((data['amt'] as double) / totalSpending),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
