import 'package:flutter/material.dart';
import 'package:inov_connect/http/webclients/chats_webclient.dart';
import 'package:inov_connect/screens/chat/chat_messages.dart';

class ChatItem extends StatelessWidget {
  final ChatsWebClient _chatsWebClient = ChatsWebClient();

  ChatItem({
    Key key,
    this.chatId,
    this.yourId,
    this.memberId,
    this.memberUserId,
    this.image,
    this.users,
    this.postTitle,
    this.highlight,
    this.callback
  }) : super(key: key);

  final int chatId;
  final int yourId;
  final int memberId;
  final int memberUserId;
  final String image;
  final List users;
  final String postTitle;
  final Function callback;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _updateNotificationOfChat();
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChatMessages(
            chatId: chatId,
            yourId: yourId,
            memberId: memberId,
            memberUserId: memberUserId,
            contact: _otherUser(users),
            contactId: _otherUserId(yourId),
          ))
        ).then((value) {
          if(value == 'OK') {
            callback();
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: highlight ? Colors.red : Colors.white,
              width: 4
            ),
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
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
                    Flexible(
                      child: Padding(
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
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    'Sobre: ',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      postTitle,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

  void _updateNotificationOfChat() {
    String whoToUpdate = yourId == memberUserId ? 'member' : 'owner';
    _chatsWebClient.updateChatNotifications(whoToUpdate, chatId);
  }
}