import 'package:flutter/material.dart';
import 'package:inov_connect/components/popup_dialog.dart';
import 'package:inov_connect/http/webclients/members_webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:inov_connect/screens/users/other_profile.dart';

class DescPost extends StatelessWidget {
  final Post _postProjeto;
  DescPost(this._postProjeto);
  final MembersWebClient _membersWebClient = MembersWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text(_postProjeto.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _postProjeto.type == 'Projeto'
                ? Colors.red[400]
                : (_postProjeto.type == 'Grupo de estudo'
                    ? Colors.green[400]
                    : Colors.blue[400]),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text(
                          _postProjeto.type,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OtherProfile(otherUserId: _postProjeto.ownerId),
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(36.0),
                              ),
                              child: Image.asset(
                                'assets/images/personIcon64.jpg',
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                                child: Text(
                                  _postProjeto.username,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                                child: Text(
                                  _postProjeto.creationDate,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 6.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                          maxLines: 10,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: 'Título: ',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: _postProjeto.title,
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal
                                ),
                              )
                            ]
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Categoria(s): ',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 6.0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _postProjeto.categories
                                .map(
                                  (dynamic category) => new Text(
                                    category['name'],
                                    style: const TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                            maxLines: 10,
                            textAlign: TextAlign.left,
                            text: TextSpan(
                                text: 'Descrição:\n',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: _postProjeto.description,
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  )
                                ]))),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ButtonTheme(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      onPressed: () {
                        _addMemberToPost(context);
                      },
                      color: Color.fromARGB(255, 2, 136, 209),
                      child: Text(
                        'Participar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addMemberToPost(BuildContext context) {
    _membersWebClient.addMember(_postProjeto.id).then((resp) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return PopupDialog(
            message: 'Solicitação de participação enviada.',
          );
        }
      ).then((value) => Navigator.pop(context));
    })
    .catchError((err) {
      String error = err.toString();
      List<dynamic> message = error.split(': ');
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return PopupDialog(message: message[message.length - 1]);
        });
    });
  }
}
