import 'package:flutter/material.dart';

// * Widgets
import './widgets/transaction_form.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
// * Moodels
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker', // Title of app running on background
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  // * * Create new transaction
  void _newTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  // * * Open bottom sheet for modal form
  void _showTransactionForm(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: TransactionForm(_newTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  // * * Remove selected transaction
  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Expense Tracker')),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _showTransactionForm(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Chart(_transactions),
            ),
            TransactionList(
              transactions: _transactions,
              removeTransaction: _removeTransaction,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showTransactionForm(context),
      ),
    );
  }
}
