import 'package:flutter/material.dart';

class PopupDialogChat extends StatelessWidget {

  final String message;

  const PopupDialogChat({
    this.message
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message, textAlign: TextAlign.center,),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCELAR',
              style: TextStyle(
                color: Colors.green[400]
              ),
            )
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, 'S');
            },
            child: Text(
              'SIM',
              style: TextStyle(
                color: Colors.green[400]
              ),
            )
          )
        ],
      )
    );
  }
}