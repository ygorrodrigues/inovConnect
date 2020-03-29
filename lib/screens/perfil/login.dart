import 'package:flutter/material.dart';
import 'package:inov_connect/components/campo_texto.dart';
import 'package:inov_connect/components/example_dialog.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';
import 'package:inov_connect/screens/projetos/feed.dart';

const _dicaUsuario = '1234';
const _dicaSenha = '*****';
const _rotuloBotaoLogin = 'Entrar';
const _rotuloBotaoAguarde = 'Aguarde...';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controladorCampoUsuario = TextEditingController();
  final TextEditingController _controladorCampoSenha = TextEditingController();

  bool auth = false;
  final LoginWebClient _webClient = LoginWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo ao Inov-Connect!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('RA', style: TextStyle(fontSize: 24),),
            CampoTexto(
              controlador: _controladorCampoUsuario,
              dica: _dicaUsuario,
              tamanhoFonte: 32,
              padLeft: 24,
              padRight: 24,
            ),
            Text('Senha', style: TextStyle(fontSize: 24),),
            CampoTexto(
              controlador: _controladorCampoSenha,
              obscuro: true,
              dica: _dicaSenha,
              tamanhoFonte: 32,
              padLeft: 24,
              padRight: 24,
            ),
            RaisedButton(
              onPressed: () => _validaLogin(context),
              child: Text(
                auth ? _rotuloBotaoAguarde : _rotuloBotaoLogin,
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _validaLogin(BuildContext context){
    final String usuario = _controladorCampoUsuario.text;
    final String senha = _controladorCampoSenha.text;

    setState((){
      auth = !auth;
    });

    _webClient.createToken(usuario, senha)
      .then((resp) {
        print('Resposta: $resp');
        if(resp['accessToken'] != null){
          setState((){
            auth = !auth;
          });
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ProjectsFeed();
            })
          );
        } else {
          setState((){
            auth = !auth;
          });
          showDialog(context: context, builder: (context) {
            return ExampleDialog();
          });
        }
      });
  }
}