import 'package:flutter/material.dart';

class PlayFlexible extends StatelessWidget {
  const PlayFlexible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flexible Demo App'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
            child: Center(
              child: Text('Text 1'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
              child: Text('Text 2'),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: Text('Text 3'),
            ),
          ),
        ],
      ),
    );
  }
}
