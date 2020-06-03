import 'package:flutter/material.dart';
import 'package:inov_connect/components/centered_message.dart';
import 'package:inov_connect/components/progress.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:inov_connect/screens/posts/form.dart';
import 'package:inov_connect/screens_dev/posts/feed_item.dart';
import 'package:inov_connect/screens_dev/users/signin.dart';

final LoginWebClient _loginWebClient = LoginWebClient();

class Feed extends StatefulWidget {

  final PostsWebClient _webClient = PostsWebClient();

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inov-Connect'),
        actions: <Widget>[
            IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _loginWebClient.removeToken().then((response) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Signin();
                  })
                );
              });
            },)
        ],
      ),
      body: FutureBuilder<List<Post>>(
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
                final List<Post> _postsProjetos = snapshot.data;
                if(_postsProjetos.isNotEmpty){
                  return ListView.builder(
                    itemBuilder: (context, index){
                      final Post post = _postsProjetos[index];
                      return FeedItem(post);
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
        onPressed: () {
          Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) {
                return FormularioPost();
              }
            )
          );
        },
      ),
    );
  }
}