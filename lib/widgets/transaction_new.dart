import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionNew extends StatefulWidget {
  const TransactionNew(this.submitHandler, {Key? key}) : super(key: key);

  final Function submitHandler;

  @override
  _TransactionNewState createState() => _TransactionNewState();
}

class _TransactionNewState extends State<TransactionNew> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitTransaction() {
    final titleText = _titleController.text;
    final amountText = double.parse(_amountController.text);

    if (titleText.isEmpty && amountText <= 0) {
      return;
    }

    widget.submitHandler(titleText, amountText, _selectedDate);
    // Navigator.of(context).pop();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) {},
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) {},
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Picked date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    ).then(
                      (value) {
                        if (value == null) return;
                        setState(() => _selectedDate = value);
                      },
                    );
                  },
                  child: const Text(
                    'Choose date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () => _submitTransaction(),
              child: const Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
