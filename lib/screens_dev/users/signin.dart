import 'package:flutter/material.dart';
import 'package:inov_connect/components/example_dialog.dart';
import 'package:inov_connect/components/text_field.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';
import 'package:inov_connect/screens_dev/posts/feed.dart';
import 'package:inov_connect/screens_dev/users/signup.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final LoginWebClient _webClient = LoginWebClient();

  final TextEditingController _controllerRA =
    TextEditingController();
  final TextEditingController _controllerPassword = 
    TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 0, top: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(48.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              InovTextField(
                controller: _controllerRA,
                inputType: TextInputType.number,
                icon: Icons.account_box,
                label: 'RA',
                padBottom: 16.0,
              ),
              InovTextField(
                controller: _controllerPassword,
                obscure: true,
                icon: Icons.lock,
                label: 'Senha',
                padBottom: 8.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lightBlue[300],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 72.0, bottom: 16.0),
                child: ButtonTheme(
                  height: 80,
                  minWidth: 300,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    onPressed: () {
                      _loginValidation(context);
                    },
                    color: Colors.lightBlue[300],
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  InkWell(
                    child: Text(
                      'Ainda não criou sua conta? ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.lightBlue[300],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 200.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        'Criar',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.lightBlue[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginValidation(BuildContext context) {
    final String usuario = _controllerRA.text;
    final String senha = _controllerPassword.text;

    _webClient.createToken(usuario, senha).then((resp) {
      if (resp['accessToken'] != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Feed();
        }));
      }
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
        });
    });
  }
}
