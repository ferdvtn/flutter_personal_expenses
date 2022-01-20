import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './widgets/transaction_new.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
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
        accentColor: Platform.isAndroid
            ? Colors.amber
            : Colors.yellow, // ignore: deprecated_member_use
        errorColor: Colors.pinkAccent,
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
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Gas',
      amount: 20,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Breaking Time',
      amount: 2.8,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'App Purchase',
      amount: 12,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((usrTx) {
      return usrTx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = true;

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((usrTx) => usrTx.id == id);
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
    var appBarTemplate = Platform.isAndroid
        ? AppBar(
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
          )
        : CupertinoNavigationBar(
            middle: Text(
              widget.appBarTitle,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _openModalTransaction,
                  child: const Icon(CupertinoIcons.add),
                )
              ],
            ),
          );

    final appBar = appBarTemplate as PreferredSizeWidget;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    final bodyHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        appBar.preferredSize.height;

    final appBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPortrait)
              Container(
                padding: const EdgeInsets.all(0.0),
                height: bodyHeight * 0.3,
                child: Chart(_recentTransactions),
              ),
            if (isPortrait)
              Container(
                padding: const EdgeInsets.all(0.0),
                height: bodyHeight * 0.7,
                child: TransactionList(_userTransactions, _deleteTransaction),
              ),
            if (isLandscape)
              Container(
                color: Theme.of(context).secondaryHeaderColor,
                height: bodyHeight * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show Chart : ',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Switch.adaptive(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      value: _showChart,
                      onChanged: (value) {
                        setState(() => _showChart = value);
                      },
                    ),
                  ],
                ),
              ),
            if (isLandscape)
              _showChart
                  ? Container(
                      padding: const EdgeInsets.all(0.0),
                      height: bodyHeight * 0.7,
                      child: Chart(_recentTransactions),
                    )
                  : Container(
                      padding: const EdgeInsets.all(0.0),
                      height: bodyHeight * 0.7,
                      child: TransactionList(
                          _userTransactions, _deleteTransaction),
                    ),
          ],
        ),
      ),
    );

    // scaffold
    final androidScaffold = Scaffold(
      appBar: appBar,
      body: appBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              elevation: 3,
              child: const Icon(Icons.add),
              onPressed: _openModalTransaction,
            )
          : Container(),
    );

    final iosScaffold = CupertinoPageScaffold(
      navigationBar: appBar as ObstructingPreferredSizeWidget,
      child: appBody,
    );

    return Platform.isAndroid ? androidScaffold : iosScaffold;
  }
}
