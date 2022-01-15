import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_new.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'OpenSans',
        primarySwatch: Colors.purple,
        accentColor: Colors.blue,
        textTheme: const TextTheme(
          headline6: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home: const MyHomePage(appBarTitle: 'FCG : Part 4'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.appBarTitle, Key? key}) : super(key: key);

  final String appBarTitle;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Gas',
    //   amount: 20,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'Breaking Time',
    //   amount: 2.8,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't5',
    //   title: 'App Purchase',
    //   amount: 12,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _openModalTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext modalContext) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: TransactionNew(_addNewTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.appBarTitle,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'OpenSans',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openModalTransaction,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart
            Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              height: null,
              width: double.infinity,
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 3,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Chart!'),
                ),
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        child: const Icon(Icons.add),
        onPressed: _openModalTransaction,
      ),
    );
  }
}
