import 'package:flutter/material.dart';
import 'package:inov_connect/screens/users/forgot.dart';
import 'package:inov_connect/screens/users/signup.dart';
// import 'package:inov_connect/components/campo_texto.dart';
// import 'package:inov_connect/components/example_dialog.dart';
// import 'package:inov_connect/http/webclients/login_webclient.dart';
// import 'package:inov_connect/screens/projetos/feed.dart';

// const _dicaUsuario = '1234';
// const _dicaSenha = '*****';
// const _rotuloBotaoLogin = 'Entrar';
// const _rotuloBotaoAguarde = 'Aguarde...';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  // final TextEditingController _controladorCampoUsuario =
  //     TextEditingController();
  // final TextEditingController _controladorCampoSenha = TextEditingController();

  // bool auth = false;
  // final LoginWebClient _webClient = LoginWebClient();

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
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    prefixIcon: Icon(
                      Icons.account_box,
                      size: 32.0,
                      color: Colors.black45,
                    ),
                    labelText: 'RA',
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlue[300],
                        width: 2,
                      ),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 32.0,
                      color: Colors.black45,
                    ),
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlue[300],
                        width: 2,
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
              Padding(
                padding: const EdgeInsets.only(top: 72.0, bottom: 16.0),
                child: ButtonTheme(
                  height: 80,
                  minWidth: 300,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    onPressed: () {},
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
                  Text(
                    'Ainda não criou sua conta? ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lightBlue[300],
                    ),
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

  // void _validaLogin(BuildContext context) {
  //   final String usuario = _controladorCampoUsuario.text;
  //   final String senha = _controladorCampoSenha.text;

  //   setState(() {
  //     auth = !auth;
  //   });

  //   _webClient.createToken(usuario, senha).then((resp) {
  //     print('Resposta: $resp');
  //     if (resp['accessToken'] != null) {
  //       setState(() {
  //         auth = !auth;
  //       });
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return ProjectsFeed();
  //       }));
  //     } else {
  //       setState(() {
  //         auth = !auth;
  //       });
  //       showDialog(
  //           context: context,
  //           builder: (context) {
  //             return ExampleDialog();
  //           });
  //     }
  //   });
  // }
}
