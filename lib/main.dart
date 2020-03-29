import 'package:flutter/material.dart';
import 'package:inov_connect/screens/perfil/login.dart';

void main() {
  runApp(InovConnect());
}

class InovConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red[800],
        accentColor: Colors.indigoAccent[400],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigoAccent[400],
          textTheme: ButtonTextTheme.primary,
        )
      ),
      home: Login()
    );
  }
}