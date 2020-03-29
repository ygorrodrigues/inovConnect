import 'package:flutter/material.dart';
import 'package:inov_connect/components/centered_message.dart';
import 'package:inov_connect/components/progress.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';
import 'package:inov_connect/models/post_projeto.dart';
import 'package:inov_connect/screens/projetos/descricao.dart';
import 'package:inov_connect/screens/projetos/formulario.dart';

const _tituloAppBar = 'Inov-Connect';

class ProjectsFeed extends StatefulWidget {

  final PostsWebClient _webClient = PostsWebClient();

  @override
  State<StatefulWidget> createState() {
    return ProjectsFeedState();
  }  
}

class ProjectsFeedState extends State<ProjectsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        actions: <Widget>[
            
        ],
      ),
      body: FutureBuilder<List<PostProjeto>>(
        initialData: List(),
        future: widget._webClient.findAll(),
        builder: (context, snapshot){

          switch(snapshot.connectionState) {
            
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return ProgressLoading(message: 'Carregando');
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(snapshot.hasData){
                final List<PostProjeto> _postsProjetos = snapshot.data;
                if(_postsProjetos.isNotEmpty){
                  return ListView.builder(
                    itemBuilder: (context, index){
                      final PostProjeto post = _postsProjetos[index];
                      return _ItemPostProjeto(post);
                    },
                    itemCount: _postsProjetos.length,
                  );
                }
                return CenteredMessage('No posts found...', icon: Icons.warning);
              }
              break;
          }
          return CenteredMessage("Unknown error...", icon: Icons.close);          
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _goToForm(context),
      ),
    );
  }

  void _goToForm(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return FormularioPost();
      }
    ));
  }
}

class _ItemPostProjeto extends StatelessWidget {

  final PostProjeto postProjeto;
  final String botaoCard = 'Ver descrição';

  const _ItemPostProjeto(this.postProjeto);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text(
            postProjeto.title,
            style: TextStyle(fontSize: 24),
          ),
          subtitle: Text(
            postProjeto.subtitle,
            style: TextStyle(fontSize: 16),
          ),
        ),
        ButtonBar(children: <Widget>[
          FlatButton(
            child: Text(
              botaoCard,
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return DescProjeto(postProjeto);
                }
              ));
            },
          )
        ],)
      ],),
    );
  }
}