import 'package:flutter/material.dart';
import './transaction_list.dart';
import './transaction_new.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionNew(),
        TransactionList(),
      ],
    );
  }
}
