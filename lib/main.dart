import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        accentColor: Colors.amber, // ignore: deprecated_member_use
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final appBar = AppBar(
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
    );

    final bodyHeight = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
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
                height: bodyHeight * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show Chart : ',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Switch(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        child: const Icon(Icons.add),
        onPressed: _openModalTransaction,
      ),
    );
  }
}
