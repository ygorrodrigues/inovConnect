import 'package:flutter/material.dart';
// import 'package:inov_connect/components/campo_texto.dart';
// import 'package:inov_connect/components/example_dialog.dart';
// import 'package:inov_connect/http/webclients/login_webclient.dart';
// import 'package:inov_connect/screens/projetos/feed.dart';

// const _dicaUsuario = '1234';
// const _dicaSenha = '*****';
// const _rotuloBotaoLogin = 'Entrar';
// const _rotuloBotaoAguarde = 'Aguarde...';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final TextEditingController _controladorCampoUsuario =
  //     TextEditingController();
  // final TextEditingController _controladorCampoSenha = TextEditingController();

  // bool auth = false;
  // final LoginWebClient _webClient = LoginWebClient();

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
                  'assets/images/logo.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 40.0,
                right: 40.0,
                bottom: 5.0,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'RA',
                  labelStyle: TextStyle(
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue[400],
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
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 40.0,
                right: 40.0,
                bottom: 5.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    fontSize: 18,
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
            ButtonTheme(
              minWidth: 330.0,
              buttonColor: Colors.lightBlue[400],
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  'Entrar',
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
                  'Criar conta',
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
