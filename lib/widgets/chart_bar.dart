import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  // const ChartBar({ Key? key }) : super(key: key);

  final String label;
  final double spendingamt;
  final double spendingprcnt;

  ChartBar(this.label, this.spendingamt, this.spendingprcnt);

  @override
  Widget build(BuildContext context) {
    // final curlSpace = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(children: [
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(
            //FittedBox fits the text in given space
            child: Text(' ₹${spendingamt.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.05),
        Container(
          height: constraints.maxHeight * 0.6,
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
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(
            child: Text(
              '$label',
              style: TextStyle(
                  // fontSize: 20,
                  ),
            ),
          ),
        )
      ]);
    });
  }
}
