import 'package:flutter/material.dart';
import 'package:inov_connect/components/example_dialog.dart';
import 'package:inov_connect/http/webclients/members_webclient.dart';
import 'package:inov_connect/screens/chat/chat_messages.dart';

class ChatItem extends StatelessWidget {
  final MembersWebClient _membersWebClient = MembersWebClient();

  ChatItem({
    Key key,
    this.chatId,
    this.yourId,
    this.memberId,
    this.memberUserId,
    this.image,
    this.users,
    this.updateDate,
    this.postTitle,
    this.callback
  }) : super(key: key);

  final int chatId;
  final int yourId;
  final int memberId;
  final int memberUserId;
  final String image;
  final List users;
  final String updateDate;
  final String postTitle;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChatMessages(
            chatId: chatId,
            yourId: yourId,
            contact: _otherUser(users),
            contactId: _otherUserId(yourId),
          )));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(36.0),
                        ),
                        child: Image.asset(
                          '$image',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _otherUser(users),
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: Text(
                              '$postTitle',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              '$updateDate',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 69, 90, 100),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                memberUserId != yourId ?
                Row(
                  children: <Widget>[
                    Text('Participação: '),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                      child: ButtonTheme(
                        height: 15,
                        minWidth: 90,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          onPressed: () {
                            _changeMemberStatus(context, 4);
                          },
                          color: Color.fromARGB(255, 241, 78, 78),
                          child: Text(
                            'Recusar',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ButtonTheme(
                      height: 15,
                      minWidth: 90,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        onPressed: () {
                          _changeMemberStatus(context, 3);
                        },
                        color: Color.fromARGB(255, 71, 198, 83),
                        child: Text(
                          'Aceitar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _otherUser(List users) {
    for (var i=0; i<users.length; i++) {
      if (users[i]['id'] != yourId)
        return users[i]['name'];
    }
    return 'Erro';
  }

  int _otherUserId(int yourId) {
    for (var i=0; i<users.length; i++) {
      if (users[i]['id'] != yourId)
        return users[i]['id'];
    }
    return 0;
  }

  void _changeMemberStatus(BuildContext context, int newStatus) {
    _membersWebClient.changeMemberStatus(memberId, newStatus)
      .then((resp) {
        switch(newStatus) {
          case 3:
            showDialog(
              context: context,
              builder: (context) {
                return ExampleDialog(
                  message: 'Usuário aceito na publicação.',
                );
              }
            );
            callback();
            break;
          case 4:
            showDialog(
              context: context,
              builder: (context) {
                return ExampleDialog(
                  message: 'Usuário recusado na publicação.',
                );
              }
            );
            callback();
            break;
          default:
            showDialog(
              context: context,
              builder: (context) {
                return ExampleDialog(
                  message: 'Um erro ocorreu...',
                );
              }
            );
        }
      })
      .catchError((err) {
        print(err);
      });
  }
}