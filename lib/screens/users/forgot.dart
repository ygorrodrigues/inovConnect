import 'package:flutter/material.dart';
import 'package:inov_connect/components/popup_dialog.dart';
import 'package:inov_connect/components/text_field.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';

class Forgot extends StatefulWidget {

  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  List<Map> _emailOptions = [
    {'id': 0, 'name': '@alunos.unisanta.br'},
    {'id': 1, 'name': '@unisanta.br'}
  ];
  String _emailSelection = '0';
  final LoginWebClient _loginWebClient = LoginWebClient();
  final TextEditingController _controllerEmail = TextEditingController();

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
                    child: InovTextField(
                      controller: _controllerEmail,
                      icon: Icons.mail,
                      hint: 'Digite seu email institucional',
                      padBottom: 8.0,
                      padRight: 8.0,
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
                          value: _emailSelection,
                          icon: Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _emailSelection = newValue;
                            });
                          },
                          items: _emailOptions
                              .map<DropdownMenuItem<String>>((Map map) {
                            return DropdownMenuItem<String>(
                                value: map['id'].toString(),
                                child: Text(
                                  map['name'],
                                  overflow: TextOverflow.ellipsis,
                                ));
                          }).toList(),
                        ),
                      ))
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
                      _sendEmail(context);
                    },
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

  void _sendEmail(BuildContext context) {
    final String email = _controllerEmail.text + _emailOptions[int.parse(_emailSelection)]['name'];
    _loginWebClient.resetPassword(email).then((resp) {
      String message = resp['message'];
      if(resp['user']) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return PopupDialog(
              message: message,
            );
        }).then((value) => Navigator.pop(context));
      }
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return PopupDialog(
            message: message
          );
      });
    })
    .catchError((err) {
      String error = err.toString();
      List<dynamic> message = error.split(': ');
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return PopupDialog(
            message: message[message.length - 1]
          );
        });
    });
  }
}
