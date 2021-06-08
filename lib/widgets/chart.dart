import 'package:intl/intl.dart';

import '/models/transaction.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  // const Chart({Key? key}) : super(key: key);
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);
  List<Map<String, Object>> get grpdTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amt;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'DAY': DateFormat.E().format(weekDay).substring(0),
        'amt': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(grpdTransactions);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
          children: (grpdTransactions as List<Map<String, Object>>).map((data) {
            return Text(
              data['DAY'].toString() + ':' + data['amt'].toString(),
            );
          }).toList(),
        ));
  }
}
