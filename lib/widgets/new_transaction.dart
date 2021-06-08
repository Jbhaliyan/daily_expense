import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amtControler = TextEditingController();
  DateTime? _selectedDate;
  void _submitData() {
    if (_amtControler.text.isEmpty) return;
    final enterTitle = _titleController.text;
    final enterAmt = double.parse(_amtControler.text);

    if (enterTitle.isEmpty || enterAmt <= 0 || _selectedDate == null) return;
    widget.addTx(
      enterTitle,
      enterAmt,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
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
              controller: _titleController,
              onSubmitted: (_) => _submitData,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amtControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            Container(
              height: 75,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Choosen'
                        : 'Picked Date  : ' +
                            DateFormat.yMd().format(_selectedDate!)),
                  ),
                  FlatButton(
                    onPressed: _datePicker,
                    child: Text(
                      "Choose date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text(
                'Add Transaction',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
