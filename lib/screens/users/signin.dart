import 'package:flutter/material.dart';
import 'package:inov_connect/components/popup_dialog.dart';
import 'package:inov_connect/components/popup_email_confimation.dart';
import 'package:inov_connect/components/text_field.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';
import 'package:inov_connect/screens/bottom/bottom_template.dart';
import 'package:inov_connect/screens/users/change_email.dart';
import 'package:inov_connect/screens/users/forgot.dart';
import 'package:inov_connect/screens/users/signup.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final LoginWebClient _webClient = LoginWebClient();

  final TextEditingController _controllerRA = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                ),
                InovTextField(
                  controller: _controllerRA,
                  inputType: TextInputType.number,
                  icon: Icons.account_box,
                  label: 'RA',
                  padBottom: 8.0,
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
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.02
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Forgot()));
                      },
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.lightBlue[300],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.02
                  ),
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
                InkWell(
                  child: RichText(
                    text: TextSpan(
                      text: 'Ainda não criou sua conta? ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.lightBlue[300],
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Criar',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.lightBlue[300],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginValidation(BuildContext context) {
    final String usuario = _controllerRA.text;
    final String senha = _controllerPassword.text;

    if (usuario != '') {
      _webClient.createToken(usuario, senha).then((resp) {
        if (resp['accessToken'] != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return BottomTemplate(firstIndex: 1);
          }));
        }
      }).catchError((err) {
        String fullMessage = err.toString();
        if(fullMessage.contains('Confirme')) {
          String message = fullMessage.substring(
            fullMessage.indexOf('Confirme'),
            fullMessage.indexOf('^') - 1
          );
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return PopupDialogEmailConfirmation(
                message: message
              );
            }
          ).then((value) {
            if(value == 'MODIFICAR') {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => ChangeEmail(
                    usuario: usuario
                  )
                )
              );
            }
            else if(value == 'REENVIAR') {
              String email = message.split(' - ')[1];
              _webClient.resendConfirmationEmail(email);
            }
          });
        }
        else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return PopupDialog(message: fullMessage);
            }
          );
        }
      });
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return PopupDialog(message: 'Digite um RA válido.');
        });
    }
  }
}
