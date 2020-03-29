import 'package:flutter/material.dart';

class ExampleDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ocorreu um erro...'),
      actions: <Widget>[
        FlatButton(onPressed: () {
          Navigator.pop(context);
        }, 
          child: Text('OK')
        )
      ],
    );
  }
}