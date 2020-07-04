import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String dropdownEmail = '@unisanta.br';
  String dropdownCourse = 'Selecione seu curso';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nome completo',
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
                      Icons.person,
                      size: 32.0,
                      color: Colors.black45,
                    ),
                    hintText: 'Entre com seu nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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
                      padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
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
                          hintText: 'Entre com seu email institucional',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownEmail,
                      icon: Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownEmail = newValue;
                        });
                      },
                      items: <String>['@alunos.unisanta.br', '@unisanta.br']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ))
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
                    hintText: 'Entre com seu RA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.only(left: 48.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownCourse,
                      icon: Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownCourse = newValue;
                        });
                      },
                      items: <String>[
                        'Selecione seu curso',
                        'Engenharia da Computação',
                        'Fisioterapia',
                        'Odonto',
                        'Pedagogia'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        right: 8, left: 8, bottom: 8, top: 8),
                    child: Icon(
                      Icons.work,
                      size: 32.0,
                      color: Colors.black45,
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Senha',
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
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 32.0,
                      color: Colors.black45,
                    ),
                    hintText: 'Entre com sua senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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
                      'Cadastrar',
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
