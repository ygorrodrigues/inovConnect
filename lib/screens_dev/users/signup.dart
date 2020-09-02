import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inov_connect/components/example_dialog.dart';
import 'package:inov_connect/components/text_field.dart';
import 'package:inov_connect/http/webclients/courses.dart';
import 'package:inov_connect/http/webclients/signup_webclient.dart';
import 'package:inov_connect/screens_dev/users/signin.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

bool _pwdVisibility = true;

class _SignupState extends State<Signup> {

  final SignupWebClient _signupWebClient = SignupWebClient();
  final CoursesWebClient _coursesWebClient = CoursesWebClient();

  final TextEditingController _controllerName =
    TextEditingController();
  final TextEditingController _controllerEmail =
    TextEditingController();
  final TextEditingController _controllerRA =
    TextEditingController();
  final TextEditingController _controllerPassword =
    TextEditingController();

  String dropdownEmail = '@unisanta.br';
  String _courseSelection;
  List<Map> _dropdownCourses = [{ 'id': 0, 'name': 'Selecione seu curso' }];
  List<String> _emailOptions = ['@unisanta.br', '@alunos.unisanta.br'];

  @override
  void initState() {
    super.initState();
    _coursesWebClient.listCourses().then((result) {
      _dropdownCourses = result;
      setState(() {});
    });
  }

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
              InovTextField(
                controller: _controllerName,
                icon: Icons.person,
                hint: 'Entre com seu nome',
                padBottom: 8,
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
                    flex: 6,
                    child: 
                    InovTextField(
                      controller: _controllerEmail,
                      icon: Icons.mail,
                      hint: 'Email institucional',
                      padBottom: 8.0,
                      padRight: 8.0,
                    )
                  ),
                  Expanded(
                    flex: 4,
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
                        items: _emailOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                          )
                        );
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
              InovTextField(
                controller: _controllerRA,
                inputType: TextInputType.number,
                icon: Icons.account_box,
                hint: 'Entre com seu RA',
                padBottom: 8.0,
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
                    child: 
                    DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Selecione seu curso'),
                      value: _courseSelection,
                      icon: Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _courseSelection = newValue;
                        });
                      },
                      items: _dropdownCourses
                        .map<DropdownMenuItem<String>>((Map map) {
                          return DropdownMenuItem<String>(
                            value: map['id'].toString(),
                            child: Text(map['name'])
                          );
                        }).toList(),
                    )
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
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: InovTextField(
                      controller: _controllerPassword,
                      obscure: _pwdVisibility,
                      icon: Icons.lock,
                      hint: 'Entre com sua senha',
                      padBottom: 8.0,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      padding: EdgeInsets.only(bottom: 8.0),
                      icon: Icon(
                        _pwdVisibility ? Icons.visibility_off : Icons.visibility,
                        size: 32.0,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          _pwdVisibility = !_pwdVisibility;
                        });
                      },
                    ),
                  )
                ],
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
                    onPressed: () {
                      _signupValidation(context);
                    },
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

  void _signupValidation(BuildContext context) {
    final String name = _controllerName.text;
    final String email = _controllerEmail.text + dropdownEmail;
    final String password = _controllerPassword.text;
    final String ra = _controllerRA.text;

    _signupWebClient.registerUser(name, email, password, ra, _courseSelection)
      .then((resp) {
        showDialog(
          context: context,
          builder: (context) {
            return ExampleDialog(
              message: 'E-mail de confirmação enviado. Obrigado!',
              redirWidget: Signin(),
            );
          }
        );
      })
      .catchError((err) {
        String error = err.toString();
        List<dynamic> message = error.split(': ');
        showDialog(
          context: context,
          builder: (context) {
            return ExampleDialog(
              message: message[message.length - 1]
            );
          }
        );
      });
  }
}
