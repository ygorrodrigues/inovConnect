import 'package:flutter/material.dart';

class PopupDialogEmailConfirmation extends StatelessWidget {

  final String message;

  const PopupDialogEmailConfirmation({
    this.message
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message, textAlign: TextAlign.center,),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context, 'MODIFICAR');
            },
            child: Text(
              'ESTE NÃO É MEU EMAIL',
              style: TextStyle(
                color: Colors.green[400]
              ),
            )
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, 'REENVIAR');
            },
            child: Text(
              'REENVIAR EMAIL',
              style: TextStyle(
                color: Colors.green[400]
              ),
            )
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
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