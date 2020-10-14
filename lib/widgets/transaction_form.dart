import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function addTransaction;

  TransactionForm(this.addTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleTextController = TextEditingController();
  final _amountTextController = TextEditingController();
  DateTime _dateSelected;

  void _validateTransaction() {
    final title = _titleTextController.text;
    final amount = double.parse(_amountTextController.text);
    final date = _dateSelected;
    // validate form
    if (title.isEmpty || amount <= 0 || date == null) {
      return;
    }
    // add transaction
    widget.addTransaction(title, amount, date);

    Navigator.of(context).pop();
  }

  void _showDatePicker() async {
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now());
    if (selectedDate == null) {
      return;
    }
    setState(() {
      _dateSelected = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleTextController,
            onSubmitted: (_) => _validateTransaction(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountTextController,
            onSubmitted: (_) => _validateTransaction(),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dateSelected == null
                    ? Text('No selected date')
                    : Text(DateFormat.yMEd().format(_dateSelected)),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text('Select Date'),
                  onPressed: () => _showDatePicker(),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                'Add',
              ),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
              onPressed: _validateTransaction,
            ),
          )
        ],
      ),
    );
  }
}
