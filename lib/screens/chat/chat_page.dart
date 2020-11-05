import 'package:flutter/material.dart';
import 'package:inov_connect/components/centered_message.dart';
import 'package:inov_connect/components/popup_dialog.dart';
import 'package:inov_connect/components/progress.dart';
import 'package:inov_connect/http/webclients/chats_webclient.dart';
import 'package:inov_connect/screens/users/signin.dart';
import 'package:inov_connect/screens/chat/chat_item.dart';

class ChatPage extends StatefulWidget {
  final ChatsWebClient _chatsWebClient = ChatsWebClient();
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> _myData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text('Conversas')
      ),
      body: RefreshIndicator(
        onRefresh: _updateScreen,
        child: FutureBuilder<List<dynamic>>(
          future: widget._chatsWebClient.listChats(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return ProgressLoading(message: 'Carregando');
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  _myData = snapshot.data;
                  
                  if (snapshot.data.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> item = _myData[index];
                        return ChatItem(
                          chatId: item['id'],
                          yourId: item['yourId'],
                          memberId: item['member']['id'],
                          memberUserId: item['member']['user_id'],
                          image: 'assets/images/personIcon76.jpg',
                          postTitle: item['post_title'],
                          users: item['users'],
                          highlight: item['yourId'] == item['member']['user_id']
                            ? !item['member_notified'] : !item['owner_notified'],
                          callback: this.chatsCallback
                        );
                      },
                      itemCount: _myData.length,
                    );                  
                  }
                  return CenteredMessage('No chat found...',
                      icon: Icons.warning);
                }
                break;
            }
            if(snapshot.hasError) {
              Map<String, dynamic> error = snapshot.error;
              if(error['statusCode'] == 401) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return PopupDialog(
                      message: 'Sessão expirada',
                    );
                  }
                ).then((value) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Signin()
                  )
                ));
              }
              else print(error);
            }
            return CenteredMessage('Unknown error...', icon: Icons.close);
          }
        ),
      )
    );
  }

  Future<Null> _updateScreen() async {
    await Future.delayed(Duration(microseconds: 500));
    setState(() {});
    return null;
  }

  void chatsCallback() async {
    await Future.delayed(Duration(microseconds: 500));
    setState(() {});
  }
}
