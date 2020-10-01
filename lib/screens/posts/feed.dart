import 'package:flutter/material.dart';
import 'package:inov_connect/components/centered_message.dart';
import 'package:inov_connect/components/example_dialog.dart';
import 'package:inov_connect/components/progress.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:inov_connect/screens/posts/form.dart';
import 'package:inov_connect/screens/posts/feed_item.dart';
import 'package:inov_connect/screens/posts/filter_dialog.dart';
import 'package:inov_connect/screens/users/signin.dart';

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
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return FilterDialog(
                    message: 'Escolha seus filtros!',
                    onSelectedOkDialog: (valuesOfDialog) {
                      if (typeSelected != valuesOfDialog[0] ||
                          categorySelected != valuesOfDialog[1]) {
                        setState(() {
                          typeSelected = valuesOfDialog[0];
                          categorySelected = valuesOfDialog[1];
                        });
                      }
                    });
                });
            },
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        initialData: {},
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
                List<dynamic> data = snapshot.data['data'];
                _postsProjetos =
                    data.map((dynamic json) => Post.fromJson(json)).toList();
                if (_postsProjetos.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final Post post = _postsProjetos[index];
                        return FeedItem(post, snapshot.data['yourId']);
                      },
                      itemCount: _postsProjetos.length,
                    ),
                  );
                }
                return CenteredMessage('No posts found',
                    icon: Icons.warning);
              }
              break;
          }
          if (snapshot.hasError) {
            Map<String, dynamic> error = snapshot.error;
            if (error['statusCode'] == 401) {
              return ExampleDialog(
                message: 'Sessão expirada',
                redirWidget: Signin(),
              );
            } else
              print(error);
          }
          return CenteredMessage('Unknown error', icon: Icons.close);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[300],
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormPost();
          }));
        },
      ),
    );
  }
}
