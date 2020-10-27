import 'package:flutter/material.dart';
import 'package:inov_connect/components/popup_dialog.dart';
import 'package:inov_connect/http/webclients/members_webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:inov_connect/screens/users/other_profile.dart';

class DescPost extends StatefulWidget {
  final Post _postProjeto;
  DescPost(this._postProjeto);

  @override
  _DescPostState createState() => _DescPostState();
}

class _DescPostState extends State<DescPost> {
  final MembersWebClient _membersWebClient = MembersWebClient();
  bool alreadyParticipates = false;
  List<dynamic> usersOfThisPost = [];

  @override
  void initState() {
    super.initState();
    _membersWebClient.listMembers(widget._postProjeto.id)
      .then((value) {
        for(Map<String, dynamic> item in value['data']) {
          if(item['user']['id'] == value['yourId']) {
            alreadyParticipates = true;
          }
          if(item['member_status']['name'] == 'Aceito') {
            usersOfThisPost.add(item);
          }
        }
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text(widget._postProjeto.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget._postProjeto.type == 'Projeto'
                    ? Colors.red[400]
                    : (widget._postProjeto.type == 'Grupo de estudo'
                      ? Colors.green[400]
                      : Colors.blue[400]),
                ),
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          widget._postProjeto.type,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OtherProfile(otherUserId: widget._postProjeto.ownerId),
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: widget._postProjeto.username + '\n',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget._postProjeto.creationDate,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0.0),
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
                                  text: widget._postProjeto.title,
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
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: 'Categoria(s):\n',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: widget._postProjeto.categories
                              .map((dynamic category) => new TextSpan(
                                  text: category == widget._postProjeto.categories[widget._postProjeto.categories.length - 1]
                                    ? '${category['name']}'
                                    : '${category['name']}\n',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                              .toList(),
                          )
                        )
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
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
                                text: widget._postProjeto.description,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal
                                ),
                              )
                            ]
                          )
                        )
                      ),
                      usersOfThisPost.isNotEmpty
                      ? Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: 'Participantes:\n',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: usersOfThisPost
                              .map((dynamic user) {
                                return TextSpan(
                                  text: user['user']['name'] + '\n',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                );
                              }).toList()
                          )
                        )
                      ) 
                      : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: SizedBox(
                width: double.infinity,
                height: 30,
                child: ButtonTheme(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    onPressed: alreadyParticipates ? null : _addMemberToPost(context),
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
    );
  }

  Function _addMemberToPost(BuildContext context) {
    return() {
      _membersWebClient.addMember(widget._postProjeto.id).then((resp) {
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
    };
  }
}
