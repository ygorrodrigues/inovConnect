import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inov_connect/http/webclients/chats_webclient.dart';
import 'package:inov_connect/http/webclients/members_webclient.dart';
import 'package:inov_connect/screens/posts/feed.dart';
import 'package:inov_connect/screens/chat/chat_page.dart';
import 'package:inov_connect/screens/users/profile.dart';
import 'package:inov_connect/screens/notifications/notification.dart';

class BottomTemplate extends StatefulWidget {

  final int firstIndex;

  const BottomTemplate({
    Key key,
    this.firstIndex
  }) : super(key: key );

  @override
  _BottomTemplateState createState() => _BottomTemplateState();
}

class _BottomTemplateState extends State<BottomTemplate> {
  int _currentIndex = 0;
  MembersWebClient _membersWebClient = MembersWebClient();
  ChatsWebClient _chatsWebClient = ChatsWebClient();
  int _numberOfNotifications = 0;
  int _numberOfChatNotifications = 0;
  Timer verificationTimer;

  @override
  void initState() {
    super.initState();
    _currentIndex = this.widget.firstIndex;
    _verifyNotifications();
    _verifyChatNotifications();
    verificationTimer = Timer.periodic(
      new Duration(seconds: 2),
      (_) {
        _verifyNotifications();
        _verifyChatNotifications();
      }
    );
  }

  @override
  void dispose() {
    verificationTimer.cancel();
    super.dispose();
  }

  final List<Widget> _children = [
    Profile(),           //[0]
    Feed(),              //[1]
    NotificationPage(),  //[2]
    ChatPage(),          //[3]
  ];

  void onTappedBar(int index)
  {
    setState(() {
      _currentIndex = index;
    });
  }

  void _verifyNotifications() {
    _membersWebClient.listNewNotifications()
    .then((data) {
      int n = 0;
      for (var i = 0; i < data['data'].length; i++) {
        Map<String,dynamic> item = data['data'][i];
        if(!item['owner_notified'] 
          && item['post']['user_id'] == data['yourId']) {
            n++;
          }
        else if (!item['member_notified']
          && item['user']['id'] == data['yourId']) {
            n++;
          }
      }
      setState(() {
        _numberOfNotifications = n;
      });
    });
  }

  void _verifyChatNotifications() {
    _chatsWebClient.listChatsNotifications()
    .then((data) {
      int n = 0;
      for (var i = 0; i < data.length; i++) {
        Map<String,dynamic> item = data[i];
        if(!item['member_notified']
          && item['member']['user_id'] == item['yourId']) {
            n++;
          }
        else if (!item['owner_notified']
          && item['member']['user_id'] != item['yourId']) {
            n++;
          }
      }
      setState(() {
        _numberOfChatNotifications = n;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 32,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: _numberOfNotifications != 0 
              ? Stack(
                children: [
                  new Icon(Icons.notifications),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        '$_numberOfNotifications',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  )
                ],
              )
              : Icon(Icons.notifications),
            title: Text('Notificações'),
          ),
          BottomNavigationBarItem(
            icon: _numberOfChatNotifications != 0 
              ? Stack(
                children: [
                  new Icon(Icons.chat),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        '$_numberOfChatNotifications',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  )
                ],
              )
              : Icon(Icons.chat),
            title: Text('Chats'),
          ),
        ],
        backgroundColor: Colors.lightBlue[300],
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white70,
        onTap: onTappedBar,
      ),
    );
  }
}
