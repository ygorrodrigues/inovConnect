import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {

  final String message;

  const PopupDialog({
    this.message
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK')
        )
      ],
    );
  }
}