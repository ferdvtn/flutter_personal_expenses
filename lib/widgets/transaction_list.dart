import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteHandler, {Key? key})
      : super(key: key);

  final List<Transaction> transactions;
  final Function deleteHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
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
                return Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => deleteHandler(transactions[index].id),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                    title: Text(transactions[index].title),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
