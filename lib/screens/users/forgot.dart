import 'package:flutter/material.dart';

class Forgot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 64.0,
                ),
                child: Text(
                  'Preencha os campos abaixo, um e-mail será enviado para você.',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'E-mail institucional',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
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
                          prefixIcon: Icon(
                            Icons.mail,
                            size: 32.0,
                            color: Colors.black45,
                          ),
                          hintText: 'Digite seu email institucional',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
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
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'RA',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.account_box,
                      size: 32.0,
                      color: Colors.black45,
                    ),
                    hintText: 'Digite seu RA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
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
                padding: const EdgeInsets.only(top: 96.0, bottom: 16.0),
                child: ButtonTheme(
                  height: 80,
                  minWidth: 300,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    onPressed: () {},
                    color: Colors.white,
                    child: Text(
                      'Recuperar',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.lightBlue[300],
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Text(
                    'Você já tem uma conta? ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 176.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
