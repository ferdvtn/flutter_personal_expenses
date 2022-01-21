import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteHandler;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('\$${transaction.amount}'),
            ),
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 300
            ? TextButton.icon(
                onPressed: () => deleteHandler(
                  transaction.id,
                ),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: const Text('Delete'),
              )
            : IconButton(
                onPressed: () => deleteHandler(
                  transaction.id,
                ),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
        title: Text(transaction.title),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
      ),
    );
  }
}
