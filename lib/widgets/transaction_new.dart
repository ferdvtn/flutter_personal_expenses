import 'package:flutter/material.dart';

class TransactionNew extends StatefulWidget {
  const TransactionNew(this.submitHandler, {Key? key}) : super(key: key);

  final Function submitHandler;

  @override
  _TransactionNewState createState() => _TransactionNewState();
}

class _TransactionNewState extends State<TransactionNew> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitTransaction() {
    final titleText = titleController.text;
    final amountText = double.parse(amountController.text);

    if (titleText.isEmpty && amountText <= 0) {
      return;
    }

    widget.submitHandler(titleText, amountText);
    // Navigator.of(context).pop();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitTransaction(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitTransaction(),
            ),
            TextButton(
              onPressed: () => submitTransaction(),
              child: const Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
