import 'package:flutter/material.dart';

class EditPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.lightBlue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Guilherme L.Fernandez',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlue[300],
                          ),
                          borderRadius: new BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Curso',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.lightBlue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Egenharia de Computação',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlue[300],
                          ),
                          borderRadius: new BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.lightBlue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlue[400],
                          ),
                          borderRadius: new BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: ButtonTheme(
                      height: 30,
                      minWidth: 350,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            40.0,
                          ),
                        ),
                        onPressed: () {},
                        color: Colors.lightBlue[300],
                        child: Text(
                          'Editar',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}