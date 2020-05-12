import 'package:flutter/material.dart';

import 'package:inov_connect/components/campo_texto.dart';
import 'package:inov_connect/components/example_dialog.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';
import 'package:inov_connect/screens/projetos/feed.dart';

const _labelRA = 'RA';
const _labelPwd = 'Senha';
const _buttonLabelLogin = 'Entrar';
const _buttonLabelCreateAccount = 'Criar conta';
const _logo = 'assets/images/logo.png';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerUser =
      TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool auth = false;
  final LoginWebClient _webClient = LoginWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(64.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                child: Image.asset(
                  _logo,
                ),
              ),
            ),
            CampoTexto(
              controller: _controllerUser,
              padTop: 5.0,
              padLeft: 40.0,
              padRight: 40.0,
              padBottom: 5.0,
              inputType: TextInputType.number,
              fontColor: Colors.black,
              label: _labelRA,
              labelSize: 18
            ),
            CampoTexto(
              controller: _controllerPassword,
              obscuro: true,
              padTop: 5.0,
              padLeft: 40.0,
              padRight: 40.0,
              padBottom: 5.0,
              fontColor: Colors.black,
              label: _labelPwd,
              labelSize: 18,
            ),
            ButtonTheme(
              minWidth: 330.0,
              buttonColor: Colors.lightBlue[400],
              child: RaisedButton(
                onPressed: () { _loginValidation(context); },
                child: Text(
                  _buttonLabelLogin,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 330.0,
              buttonColor: Colors.grey[50],
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  _buttonLabelCreateAccount,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightBlue[400],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loginValidation(BuildContext context) {
    final String usuario = _controllerUser.text;
    final String senha = _controllerPassword.text;

    setState(() {
      auth = !auth;
    });

    _webClient.createToken(usuario, senha).then((resp) {
      print('Resposta: $resp');
      if (resp['accessToken'] != null) {
        setState(() {
          auth = !auth;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProjectsFeed();
        }));
      } else {
        setState(() {
          auth = !auth;
        });
        showDialog(
            context: context,
            builder: (context) {
              return ExampleDialog();
            });
      }
    });
  }
}
