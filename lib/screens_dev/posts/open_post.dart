import 'package:flutter/material.dart';
import 'package:inov_connect/models/post.dart';

class OpenPost extends StatelessWidget {

  final Post _postProjeto;

  OpenPost(this._postProjeto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_postProjeto.title),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              child: Text(
                _postProjeto.id.toString(),
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ] 
      ),
    );
  }
}