import 'package:flutter/material.dart';
import 'package:inov_connect/components/centered_message.dart';
import 'package:inov_connect/components/progress.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:inov_connect/screens/posts/form.dart';
import 'package:inov_connect/screens_dev/posts/feed_item.dart';
import 'package:inov_connect/screens_dev/posts/filter_dialog.dart';
import 'package:inov_connect/screens_dev/users/signin.dart';

final LoginWebClient _loginWebClient = LoginWebClient();

class Feed extends StatefulWidget {
  final PostsWebClient _postsWebClient = PostsWebClient();
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  List<Post> _postsProjetos;
  int typeSelected = 0;
  int categorySelected = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text('Inov-Connect'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _loginWebClient.removeToken().then((response) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Signin();
                }));
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return FilterDialog(
                    message: 'Escolha seus filtros!',
                    onSelectedOkDialog: (valuesOfDialog) {
                      if(typeSelected != valuesOfDialog[0] || 
                        categorySelected != valuesOfDialog[1]) {
                          setState(() {
                            typeSelected = valuesOfDialog[0];
                            categorySelected = valuesOfDialog[1];
                          });
                        }
                    }
                  );
                }
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List<Post>>(
        initialData: List(),
        future: widget._postsWebClient.findAll(typeSelected, categorySelected),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return ProgressLoading(message: 'Carregando');
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                _postsProjetos = snapshot.data;
                if (_postsProjetos.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Post post = _postsProjetos[index];
                      return FeedItem(post);
                    },
                    itemCount: _postsProjetos.length,
                  );
                }
                return CenteredMessage('No posts found...',
                    icon: Icons.warning);
              }
              break;
          }
          return CenteredMessage('Unknown error...', icon: Icons.close);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[300],
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioPost();
          }));
        },
      ),
    );
  }
}
