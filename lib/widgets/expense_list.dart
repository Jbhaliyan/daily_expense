import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList(this.expenses, this.deleteTx);
  final List<Expense> expenses;
  final Function deleteTx;
  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No Expenses added yet!',
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                    height: constraints.maxHeight * 0.7,
                    child:
                        Image.asset('assets/waiting.png', fit: BoxFit.cover)),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
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
                      '₹ ${expenses[index].amt.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  title: Text(
                    expenses[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(expenses[index].date),
                    // tx.date.toString(),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          textColor: Colors.red,
                          onPressed: () => deleteTx(expenses[index].id),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: Text('Delete'),
                        )
                      : IconButton(
                          onPressed: () => deleteTx(expenses[index].id),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                ),
              );
            },
            itemCount: expenses.length,
            // children: (Expenses as List<Expense>).map((tx) {
            // return
          );
  }
}
