import 'package:flutter/material.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';
import 'package:inov_connect/screens_dev/posts/descpost.dart';

class ParticipationItem extends StatelessWidget {
  final PostsWebClient _postsWebClient = PostsWebClient();

  ParticipationItem({
    Key key,
    this.postId,
    this.image,
    this.publishDate,
    this.title,
    this.notification,
    this.status,
  }) : super(key: key);

  final int postId;
  final String image;
  final String publishDate;
  final String title;
  final String notification;
  final String status;

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
        padding: const EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 0.0),
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
                      Container(
                        width: 240,
                        child: Text(
                          '$notification',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        '$title',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          _timeFormat(publishDate),
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
                  Text(
                    'Status: ',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$status',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
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
                        _seePost(context);
                      },
                      color: Color.fromARGB(255, 58, 137, 193),
                      child: Text(
                        'Ver Projeto',
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

  String _timeFormat(String publishDate) {
    int startHour = publishDate.indexOf('T');
    String date = publishDate.substring(0, startHour);
    String hour = publishDate.substring(startHour + 1, startHour + 6);
    return date + ' às ' + hour;
  }

  void _seePost(BuildContext context) {
    _postsWebClient.findOne(postId)
      .then((result) {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => DescPost(result)));
      })
      .catchError((err) {
        print('Erro: $err');
      });
  }
}