import 'package:expense_app_practice/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    Key? key,
    required this.expense,
    required this.deleteTx,
  }) : super(key: key);

  final Expense expense;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColorDark,
              width: 2.0,
            ),
          ),
          child: Text(
            '₹ ${expense.amt.toStringAsFixed(2)}',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        title: Text(
          expense.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(expense.date),
          // tx.date.toString(),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? FlatButton.icon(
                textColor: Colors.red,
                onPressed: () => deleteTx(expense.id),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: Text('Delete'),
              )
            : IconButton(
                onPressed: () => deleteTx(expense.id),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
      ),
    );
  }
}
