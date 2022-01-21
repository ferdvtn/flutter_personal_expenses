import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteHandler, {Key? key})
      : super(key: key);

  final List<Transaction> transactions;
  final Function deleteHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.2,
                      child: Text(
                        'No transaction added yet',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0.0),
                      height: constraints.maxHeight * 0.8,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(
                    transaction: transactions[index],
                    deleteHandler: deleteHandler);
              },
            ),
    );
  }
}
