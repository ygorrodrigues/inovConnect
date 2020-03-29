import 'package:flutter/material.dart';

class ProgressLoading extends StatelessWidget {

  final String message;

  ProgressLoading({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(message),
        ],
      ),
    );
  }
}