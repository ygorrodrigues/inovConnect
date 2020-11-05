import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:inov_connect/http/webclients/chats_webclient.dart';
import 'package:inov_connect/screens/users/other_profile.dart';
import 'package:inov_connect/http/webclient.dart';

import 'message.dart';

ChatsWebClient _chatsWebClient = ChatsWebClient();

class ChatMessages extends StatefulWidget {
  final int chatId;
  final int yourId;
  final String contact;
  final int contactId;
  final String role;
  const ChatMessages({
    Key key,
    this.chatId,
    this.yourId,
    this.contact,
    this.contactId,
    this.role
  }) : super(key: key);

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  List<Message> messages;
  TextEditingController _controllerMessage = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<dynamic> resultMessages;
  StreamController<List<dynamic>> _messagesController;
  IO.Socket socket;

  @override
  void initState() {
    print(widget.chatId);
    _messagesController = new StreamController();
    loadFirstMessages();
    socket = IO.io(url, <String, dynamic> {
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.io.options['extraHeaders'] = {'chatId': '${widget.chatId}'};
    socket.on('receive_message', (jsonData) {
      Map<String, dynamic> received = jsonDecode(jsonData);
      List data = [{
        'created_at': received['created_at'],
        'chatId': received['chatId'],
        'user': {
          'id': received['userId']
        },
        'message': received['message']
      }];
      resultMessages += data;
      _messagesController.add(resultMessages);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease,
        );
      });
    });
    socket.connect();
    super.initState();
  }

  loadFirstMessages() async {
    _chatsWebClient.listMessages(widget.chatId)
      .then((res) async {
        resultMessages = res;
        _messagesController.add(res);
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
        });
        return res;
      });
  }

  @override
  void dispose() {
    socket.dispose();
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
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => OtherProfile(
                        otherUserId: widget.contactId
                      )));
                  },
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(36.0),
                        ),
                        child: Image.asset(
                          'assets/images/personIcon64.jpg',
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03
                          ),
                          child: Text(
                            widget.contact,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
        widget.chatId, _controllerMessage.text, widget.role
      )
        .catchError((err) {
          print(err);
        })
        .then((r) {
          final String messageJson = jsonEncode({
            'created_at': r['created_at'],
            'chatId': widget.chatId,            
            'userId': widget.yourId,
            'message': _controllerMessage.text,
          });
          socket.emit(
            'send_message',
            messageJson
          );
          _controllerMessage.clear();
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100),
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
