import 'package:flutter/material.dart';
import 'package:inov_connect/models/post.dart';

class DescPost extends StatelessWidget {
  final Post _postProjeto;

  DescPost(this._postProjeto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //color: Colors.red[400],
            color: _postProjeto.type == 'Projeto'
                ? Colors.red[400]
                : (_postProjeto.type == 'Grupo de estudo'
                    ? Colors.green[400]
                    : Colors.blue[400]),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text(
                          //'PROJETO',
                          _postProjeto.type,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(36.0),
                            ),
                            child: Image.asset(
                              'assets/images/person64.jpg',
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Text(
                                //'Guilherme',
                                _postProjeto.username,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Text(
                                //'01/05/2020 às 14:00',
                                _postProjeto.creationDate,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Color.fromARGB(255, 69, 90, 100),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 6.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Título: ',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            //'TCC - InovConnect',
                            _postProjeto.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 6.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Categoria: ',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 6.0, 0, 6.0),
                      child: Row(
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _postProjeto.categories
                                  .map((dynamic category) => new Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 4.0, 0),
                                        child: Text(
                                          category['name'],
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))
                                  .toList()),
                          /*Text(
                        'Software',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),*/
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 64.0, 0, 6.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Descrição: ',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 6.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 360,
                            child: Text(
                              _postProjeto.description,
                              //'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 10,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                //padding: const EdgeInsets.fromLTRB(0, 100.0, 0, 0),
                child: Row(
                  children: <Widget>[
                    ButtonTheme(
                      height: 30,
                      minWidth: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Color.fromARGB(255, 211, 47, 47),
                        child: Text(
                          'Voltar',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    ButtonTheme(
                      height: 30,
                      minWidth: 150,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        onPressed: () {},
                        color: Color.fromARGB(255, 2, 136, 209),
                        child: Text(
                          'Enviar Mensagem',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
