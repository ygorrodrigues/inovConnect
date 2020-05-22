import 'package:flutter/material.dart';
import 'package:inov_connect/components/text_field.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';

const _tituloAppBar = 'Criando Post';

const _rotuloTitulo = 'Título do Projeto';
const _rotuloSubtitulo = 'Subtítulo';
const _rotuloDescricao = 'Descreva o projeto';
const _rotuloBotao = 'Enviar';

class FormularioPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioPostState();
  }
}

class FormularioPostState extends State<FormularioPost>{

  final TextEditingController _controladorCampoTituloProjeto = 
    TextEditingController();
  final TextEditingController _controladorCampoSubtituloProjeto = 
    TextEditingController();
  final TextEditingController _controladorCampoDescricaoProjeto =
    TextEditingController();
  final PostsWebClient _webClient = PostsWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_tituloAppBar),
          actions: <Widget>[
            
          ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          InovTextField(
            controller: _controladorCampoTituloProjeto,
            label: _rotuloTitulo,
            labelSize: 32,
            padTop: 8,
          ),
          InovTextField(
            controller: _controladorCampoSubtituloProjeto,
            label: _rotuloSubtitulo,
            labelSize: 24,
            padTop: 8,
          ),
          InovTextField(
            controller: _controladorCampoDescricaoProjeto,
            label: _rotuloDescricao,
            labelSize: 16,
            padTop: 8,
            inputType: TextInputType.multiline,
          ),
          RaisedButton(
            onPressed: () => {},
            child: Text(
              _rotuloBotao,
              style: TextStyle(fontSize: 24),
            ),
          )
        ],),
      ),
    );
  }

  // void _criaPost(BuildContext context) {
  //   final String tituloProjeto = 
  //     _controladorCampoTituloProjeto.text;
  //   final String subtituloProjeto =
  //     _controladorCampoSubtituloProjeto.text;
  //   final String descricaoProjeto =
  //     _controladorCampoDescricaoProjeto.text;
  //   if(tituloProjeto != '' &&
  //     subtituloProjeto != '' &&
  //     descricaoProjeto != ''){
  //       // final postCriado = PostProjeto(tituloProjeto,
  //       //   subtituloProjeto,
  //       //   descricaoProjeto);
  //       _webClient.save(postCriado).then((postProjeto) {
  //         if(postProjeto != null) {
  //           Navigator.pop(context);
  //         }
  //       });
  //   }
  // }
}