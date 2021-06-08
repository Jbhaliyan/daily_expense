import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/transaction.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.transactions, this.deleteTx);
  final List<Transaction> transactions;
  final Function deleteTx;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Transactions added yet!',
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                    height: 200,
                    child:
                        Image.asset('assets/waiting.png', fit: BoxFit.cover)),
              ],
            )
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
                        '₹ ${transactions[index].amt.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      // tx.date.toString(),
                    ),
                    trailing: IconButton(
                      onPressed: () => deleteTx(transactions[index].id),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
              // children: (transactions as List<Transaction>).map((tx) {
              // return
            ),
    );
  }
}
