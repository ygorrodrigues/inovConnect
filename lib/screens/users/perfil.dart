import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(
            left: 25,
            right: 25,
            top: 25,
            bottom: 50,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 26,
              right: 26,
              top: 26,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(68.0),
                    ),
                    child: Image.asset(
                      'assets/images/person128.jpg',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Guilherme L.Fernandez',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lightBlue[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Curso:',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.lightBlue[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                      child: Text(
                        'Engenharia da Computação',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 142, 142, 142),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Semestre:',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.lightBlue[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                      child: Text(
                        '10º',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 142, 142, 142),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Descrição:',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.lightBlue[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo conseq.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 142, 142, 142),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Atividades Concluídas',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.lightBlue[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Projeto',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 142, 142, 142),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                          child: Text(
                            '99',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Dúvida',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 142, 142, 142),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                          child: Text(
                            '99',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Grupo de Estudos',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 142, 142, 142),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                          child: Text(
                            '99',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Últimas Atividades',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lightBlue[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'TCC - InovConnect',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color.fromARGB(255, 142, 142, 142),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Máquina do Tempo',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color.fromARGB(255, 142, 142, 142),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Bobina de Tesla',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color.fromARGB(255, 142, 142, 142),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
