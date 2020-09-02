import 'package:flutter/material.dart';

class ExampleDialog extends StatelessWidget {

  final String message;
  final Widget redirWidget;

  const ExampleDialog({
    this.message,
    this.redirWidget
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message),
      actions: <Widget>[
        FlatButton(onPressed: () {
          redirWidget != null ? 
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return redirWidget;
              }
            )) 
            : Navigator.pop(context);
        }, 
          child: Text('OK')
        )
      ],
    );
  }
}