import 'package:flutter/material.dart';
import 'package:inov_connect/screens/posts/feed.dart';
import 'package:inov_connect/screens/users/chat_page.dart';
import 'package:inov_connect/screens/users/notification.dart';
import 'package:inov_connect/screens/users/perfil.dart';

class BottomTemplate extends StatefulWidget {
  @override
  _BottomTemplateState createState() => _BottomTemplateState();
}

class _BottomTemplateState extends State<BottomTemplate> {
  int _currentIndex = 1;

  final List<Widget> _children = [
    Perfil(),            //[0]
    Feed(),              //[1]
    NotificationPage(),      //[2]
    ChatPage(),          //[3]
  ];

  void onTappedBar(int index)
  {
    setState(() {
      _currentIndex = index;
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
            icon: Icon(Icons.notifications),
            title: Text('Notificações'),
          ),
          BottomNavigationBarItem(
            icon:   Icon(Icons.chat),
            title: Text('Chats'),
          )
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
