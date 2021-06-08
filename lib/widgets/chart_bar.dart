import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  // const ChartBar({ Key? key }) : super(key: key);

  final String label;
  final double spendingamt;
  final double spendingprcnt;

  ChartBar(this.label, this.spendingamt, this.spendingprcnt);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(' ₹${spendingamt.toStringAsFixed(0)}'),
      SizedBox(height: 4),
      Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingprcnt,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // Container()
            ],
          ))
    ]);
  }
}
