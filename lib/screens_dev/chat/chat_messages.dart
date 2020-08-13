import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inov_connect/http/webclients/chats_webclient.dart';

import 'message.dart';

ChatsWebClient _chatsWebClient = ChatsWebClient();

class ChatMessages extends StatefulWidget {
  final int chatId;
  final int yourId;
  final String contact;
  const ChatMessages({
    Key key,
    this.chatId,
    this.yourId,
    this.contact
  }) : super(key: key);

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  List<Message> messages;
  TextEditingController _controllerMessage = TextEditingController();
  ScrollController _scrollController = ScrollController();
  StreamController<List<dynamic>> _messagesController;
  Timer _messageTimer;

  @override
  void initState() {
    _messagesController = new StreamController();
    _messageTimer = Timer.periodic(Duration(microseconds: 800), (_) => loadMessages());
    super.initState();
  }

  loadMessages() async {
    _chatsWebClient.listMessages(widget.chatId)
      .then((res) async {
        print('LoadDetails of $res');
        _messagesController.add(res);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut
        );
        return res;
      });
  }

  @override
  void dispose() {
    _messageTimer.cancel();
    _messagesController.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 4.0, 8.0, 4.0),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(36.0),
                      ),
                      child: Image.asset(
                        'assets/images/person64.jpg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                      child: Text(
                        widget.contact,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: _messagesController.stream,
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator()
                    );
                  }
                  messages = snapshot.data
                    .map((item) => Message(
                      message: item['message'],
                      me: item['user']['id'] == widget.yourId,
                      time: item['created_at'],
                    )).toList();
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final Widget message = messages[index];
                      return message;
                    },
                    itemCount: messages.length,
                  );
                }
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controllerMessage,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Digite alguma coisa..',
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: SendButton(
                      text: 'Enviar',
                      callback: () {
                        _sendMessage();
                      },
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if(_controllerMessage.text.length > 0) {
      _chatsWebClient.sendMessage(
        widget.chatId, _controllerMessage.text
      )
        .catchError((err) {
          print(err);
        })
        .then((r) {
          _controllerMessage.clear();
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut
          );
        });      
    }
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 30,
      minWidth: 90,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: callback,
        color: Color.fromARGB(255, 58, 137, 193),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
