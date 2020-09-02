import 'package:flutter/material.dart';

class EntryLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container (
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 0, top: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
              Text(
                'Carregando',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black
                )
              )
            ]
          )
        ),
      )
    );
  }
}
