import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amtControler = TextEditingController();

  void submitData() {
    final enterTitle = titleController.text;
    final enterAmt = double.parse(amtControler.text);

    if (enterTitle.isEmpty || enterAmt <= 0) return;
    widget.addTx(
      enterTitle,
      enterAmt,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => submitData,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amtControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            FlatButton(
              onPressed: submitData,
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purpleAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
