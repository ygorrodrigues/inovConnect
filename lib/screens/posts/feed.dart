import 'package:flutter/material.dart';
import 'package:inov_connect/components/centered_message.dart';
import 'package:inov_connect/components/progress.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:inov_connect/screens/posts/feed_item.dart';
import 'package:inov_connect/screens/posts/filter_dialog.dart';
import 'package:inov_connect/screens/posts/form.dart';
import 'package:inov_connect/screens/users/signin.dart';

class Feed extends StatefulWidget {
  final PostsWebClient _postsWebClient = PostsWebClient();
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int page = 1;
  int showLimit = 5;
  bool endOfPosts = false;
  bool updatingScreen = true;
  List<Post> _postsProjetos = [];
  Map<String, dynamic> data;
  int yourId;
  int typeSelected = 0;
  int categorySelected = 0;
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = new ScrollController();
    _updatePostsData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                        _stateCallback();
                      }
                    });
                });
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _updateScreen,
        child: updatingScreen ?
          ProgressLoading(message: 'Carregando') :
          _postsProjetos.isNotEmpty ? 
            NotificationListener(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                controller: controller,
                itemBuilder: (context, index) {
                  final Post post = _postsProjetos[index];
                  return FeedItem(post, yourId, _stateCallback);
                },
                itemCount: showLimit,
              ),
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo is ScrollEndNotification &&
                  (scrollInfo.metrics.maxScrollExtent ==
                  scrollInfo.metrics.pixels)) {
                    _scrollListener();
                    return true;
                }
                return false;
              },
            ) :
            CenteredMessage(
              'No posts found',
              icon: Icons.warning
            )
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[300],
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormPost();
          })).then((value) => value == 'Ok' ? _stateCallback() : null);
        },
      ),
    );
  }

  void _updatePostsData() {
    widget._postsWebClient.findAll(typeSelected, categorySelected, page)
      .then((value) {
        data = value;
        List<dynamic> posts = data['data'];
        if(posts.length > 0) {
          setState(() {
            yourId = data['yourId'];
            _postsProjetos.addAll(
              posts.map((dynamic json) => Post.fromJson(json))
            );
            if(showLimit >= _postsProjetos.length) {
              showLimit = _postsProjetos.length;
            }
            updatingScreen = false;
          });
        }
        else {
          setState(() {
            showLimit = _postsProjetos.length;
            endOfPosts = true;
          });
        }
      })
      .catchError((error) {
        if (error['statusCode'] != null) {
          if (error['statusCode'] == 401) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Signin()
              )
            );
          }
          else print(error);
        }
        else print(error);
      });
  }

  void _stateCallback() {
    page = 1;
    showLimit = 5;
    _postsProjetos = [];
    endOfPosts = false;
    updatingScreen = true;
    controller.jumpTo(controller.position.minScrollExtent);
    _updatePostsData();
  }

  void _scrollListener() {
    if (!endOfPosts) {
      if(showLimit + 5 < _postsProjetos.length) {
        setState(() {
          showLimit += 5;
        });
      }
      else {
        page++;
        print(page);
        _updatePostsData();
      }
    }
  }

  Future<Null> _updateScreen() async {
    await Future.delayed(Duration(microseconds: 5000));
    _stateCallback();
    return null;
  }
}