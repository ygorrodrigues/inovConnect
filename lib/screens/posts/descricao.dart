import 'package:flutter/material.dart';
import 'package:inov_connect/models/post.dart';

class DescProjeto extends StatelessWidget {

  final Post _postProjeto;

  DescProjeto(this._postProjeto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_postProjeto.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: Text(
            _postProjeto.description,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}