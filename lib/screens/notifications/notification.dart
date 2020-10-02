import 'package:flutter/material.dart';
import 'package:inov_connect/components/centered_message.dart';
import 'package:inov_connect/components/popup_dialog.dart';
import 'package:inov_connect/components/progress.dart';
import 'package:inov_connect/http/webclients/members_webclient.dart';
import 'package:inov_connect/screens/users/signin.dart';
import 'package:inov_connect/screens/notifications/participation.dart';
import 'package:inov_connect/screens/notifications/request.dart';

class NotificationPage extends StatefulWidget {
  final MembersWebClient _membersWebClient = MembersWebClient();
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> _myData;
  int _yourId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text('Notificações')
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: widget._membersWebClient.listNotifications(),
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
                _myData = snapshot.data['data'];
                _yourId = snapshot.data['yourId'];
                if (_myData.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> item = _myData[index];
                      if(item['user']['id'] == _yourId) {
                        return ParticipationItem(
                          postId: item['post']['id'],
                          image: 'assets/images/personIcon76.jpg',
                          publishDate: item['updated_at'],
                          title: item['post']['title'],
                          notification: item['status_message'],
                          status: item['member_status']['name'],
                        );
                      }
                      else {
                        return RequestItem(
                          memberId: item['id'],
                          image: 'assets/images/personIcon76.jpg',
                          username: item['user']['name'],
                          publishDate: item['updated_at'],
                          title: item['post']['title'],
                          notification: 'Solicitou a entrada no seu projeto',
                          status: item['member_status']['name'],
                          callback: this.notificationsCallback,
                        );
                      }
                    },
                    itemCount: _myData.length,
                  );                  
                }
                return CenteredMessage('No notifications found...',
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
      )
    );
  }

  void notificationsCallback() {
    setState(() {});
  }
}
