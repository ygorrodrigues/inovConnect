import 'package:flutter/material.dart';
import 'package:inov_connect/components/popup_dialog.dart';
import 'package:inov_connect/http/webclients/members_webclient.dart';
import 'package:inov_connect/screens/bottom/bottom_template.dart';

class RequestItem extends StatelessWidget {
  final MembersWebClient _membersWebClient = MembersWebClient();

  RequestItem({
    Key key,
    this.memberId,
    this.image,
    this.username,
    this.publishDate,
    this.title,
    this.notification,
    this.status,
    this.callback
  }) : super(key: key);

  final int memberId;
  final String image;
  final String username;
  final String publishDate;
  final String title;
  final String notification;
  final String status;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
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
                        '$username',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Text(
                          '$notification: $title',
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
                          publishDate,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 0),
              child: Row(
                children: <Widget>[
                  ButtonTheme(
                    height: 30,
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
                  Spacer(),
                  ButtonTheme(
                    height: 30,
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
                  Spacer(),
                  ButtonTheme(
                    height: 30,
                    minWidth: 90,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      onPressed: () {
                        _changeMemberStatus(context, 2);
                      },
                      color: Color.fromARGB(255, 58, 137, 193),
                      child: Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeMemberStatus(BuildContext context, int newStatus) {
    _membersWebClient.changeMemberStatus(memberId, newStatus)
      .then((resp) {
        if(newStatus == 2) {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) => BottomTemplate(firstIndex: 3)));
        }
        else {
          switch (newStatus) {
            case 3:
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return PopupDialog(
                    message: 'Usuário aceito na publicação.',
                  );
                }
              );
              callback();
              break;
            case 4:
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return PopupDialog(
                    message: 'Usuário recusado na publicação.',
                  );
                }
              );
              callback();
              break;
            default:
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return PopupDialog(
                    message: 'Um erro ocorreu...',
                  );
                }
              );
          }
        }
      })
      .catchError((err) {
        print(err);
      });
  }
}