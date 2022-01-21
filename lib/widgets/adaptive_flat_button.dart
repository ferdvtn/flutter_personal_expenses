import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  const AdaptiveFlatButton(this.text, this.handler, {Key? key})
      : super(key: key);

  final String text;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextButton(
            onPressed: () => handler(),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : CupertinoButton(
            onPressed: () => handler(),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
