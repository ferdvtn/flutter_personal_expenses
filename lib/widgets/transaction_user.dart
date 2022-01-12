import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_list.dart';
import './transaction_new.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
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
    )
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    // print('123');
    // final newTx = Transaction(
    //   id: DateTime.now().toString(),
    //   title: txTitle,
    //   amount: txAmount,
    //   date: DateTime.now(),
    // );

    // setState(() {
    //   _userTransactions.add(newTx);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionNew(),
        TransactionList(_userTransactions),
      ],
    );
  }
}
