import 'package:flutter/material.dart';
import 'package:inov_connect/components/example_dialog.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:inov_connect/screens/bottom/bottom_template.dart';

class EditPost extends StatefulWidget {

  final Post post;
  const EditPost({
    this.post,
  });

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final PostsWebClient _postsWebClient = PostsWebClient();

  final TextEditingController _controllerDescription =
    TextEditingController();

  String _statusSelection;
  List<Map> _dropdownStatus = [{ 'id': 0, 'name': 'Status da publicação' }];

  @override
  void initState() {
    super.initState();
    _postsWebClient.listPostStatuses().then((result) {
      _dropdownStatus = result;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.lightBlue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: _controllerDescription,
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: widget.post.description,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlue[400],
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
                    child: Text(
                      'Status: ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.lightBlue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _statusSelection,
                      icon: Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      hint: DropdownMenuItem<String>(
                        value: widget.post.postStatusId.toString(),
                        child: Text(widget.post.postStatus)
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _statusSelection = newValue;
                        });
                      },
                      items: _dropdownStatus
                        .map<DropdownMenuItem<String>>((Map map) {
                          return DropdownMenuItem<String>(
                            value: map['id'].toString(),
                            child: Text(map['name'])
                          );
                        }).toList(),                      
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonTheme(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                40.0,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.red[300],
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        ButtonTheme(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                40.0,
                              ),
                            ),
                            onPressed: () {
                              _editPost(context);
                            },
                            color: Colors.lightBlue[300],
                            child: Text(
                              'Editar',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _editPost(BuildContext context) {
    final String description = _controllerDescription.text == '' ?
      widget.post.description : _controllerDescription.text;
    final String finalStatusSelection = _statusSelection == null ?
      widget.post.postStatusId.toString() : _statusSelection;

    _postsWebClient.updatePost(widget.post.id, description, finalStatusSelection)
      .then((resp) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ExampleDialog(
              message: 'Sua publicação foi editada.',
              redirWidget: BottomTemplate(firstIndex: 0),
            );
          }
        );
      })
      .catchError((err) {
        String error = err.toString();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ExampleDialog(
              message: error
            );
          }
        );
      });
  }
}