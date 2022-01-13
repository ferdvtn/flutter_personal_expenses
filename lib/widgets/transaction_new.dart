import 'package:flutter/material.dart';

class TransactionNew extends StatelessWidget {
  TransactionNew(this.submitHandler, {Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function submitHandler;

  void submitTransaction() {
    final titleText = titleController.text;
    final amountText = double.parse(amountController.text);

    if (titleText.isEmpty && amountText <= 0) {
      return;
    }

    submitHandler(titleText, amountText);
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
              child: const Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
