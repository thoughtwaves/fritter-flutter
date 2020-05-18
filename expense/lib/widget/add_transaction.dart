import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function _addTransaction;

  AddTransaction(this._addTransaction);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _dateSelected;

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    final selectedDate = _dateSelected;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget._addTransaction(enteredTitle, enteredAmount, selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((picked) {
          if(picked == null) {
            return;
          }
          setState(() {
             _dateSelected = picked;
          });
         
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom  + 20,
          ),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => submitData(),
            ),
            Row(
              children: <Widget>[
                Expanded(
                                child: Text(_dateSelected == null ?
                    'Select Date' : DateFormat.yMMMd().format(_dateSelected),
                    style: TextStyle(fontFamily: 'Quicksand'),
                  ),
                ),
                Container(
                  child: Platform.isIOS ? CupertinoButton(
                    child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(220, 200, 20, 1),
                        child: IconButton(icon: Icon(Icons.date_range))),
                    onPressed: _datePicker,
                  ) : FlatButton(
                    child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(220, 200, 20, 1),
                        child: IconButton(icon: Icon(Icons.date_range))),
                    onPressed: _datePicker,
                  ),
                )
              ],
            ),
            RaisedButton(
              child: Text('Add Transation'),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColorDark,
              onPressed: submitData,
            )
          ],
        )),
      ),
    );
  }
}
