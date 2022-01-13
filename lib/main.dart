import 'package:flutter/material.dart';
import 'package:flutter_complete_guide_part_4/widgets/transaction_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      themeMode: ThemeMode.dark,
      home: MyHomePage(appBarTitle: 'FCG : Part 4'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({required this.appBarTitle, Key? key}) : super(key: key);

  final String appBarTitle;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart
            Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              height: null,
              width: double.infinity,
              child: const Card(
                color: Colors.purpleAccent,
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Chart!'),
                ),
              ),
            ),
            const TransactionUser(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
