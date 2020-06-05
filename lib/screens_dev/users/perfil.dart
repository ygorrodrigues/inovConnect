import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text('Perfil'),
      ),
      body: Center(child: Text("Esta é a tela de perfil"),),
    );
  }
}
