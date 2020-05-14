import 'package:flutter/material.dart';
import 'package:inov_connect/components/campo_texto.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';
import 'package:inov_connect/models/post_projeto.dart';

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
          CampoTexto(
            controlador: _controladorCampoTituloProjeto,
            rotulo: _rotuloTitulo,
            tamanhoFonte: 32,
            padTop: 8,
          ),
          CampoTexto(
            controlador: _controladorCampoSubtituloProjeto,
            rotulo: _rotuloSubtitulo,
            tamanhoFonte: 24,
            padTop: 8,
          ),
          CampoTexto(
            controlador: _controladorCampoDescricaoProjeto,
            rotulo: _rotuloDescricao,
            tamanhoFonte: 16,
            padTop: 8,
            tipoInput: TextInputType.multiline,
          ),
          RaisedButton(
            onPressed: () => _criaPost(context),
            child: Text(
              _rotuloBotao,
              style: TextStyle(fontSize: 24),
            ),
          )
        ],),
      ),
    );
  }

  void _criaPost(BuildContext context) {
    final String tituloProjeto = 
      _controladorCampoTituloProjeto.text;
    final String subtituloProjeto =
      _controladorCampoSubtituloProjeto.text;
    final String descricaoProjeto =
      _controladorCampoDescricaoProjeto.text;
    if(tituloProjeto != '' &&
      subtituloProjeto != '' &&
      descricaoProjeto != ''){
        final postCriado = PostProjeto(tituloProjeto,
          subtituloProjeto,
          descricaoProjeto);
        _webClient.save(postCriado).then((postProjeto) {
          if(postProjeto != null) {
            Navigator.pop(context);
          }
        });
    }
  }
}