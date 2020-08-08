import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: MyStatelessWidget(),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  _NotificationItem({
    Key key,
    this.image,
    this.username,
    this.publishDate,
    this.title,
    this.notification,
    this.status,
  }) : super(key: key);

  final String image;
  final String username;
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
                      Text(
                        '$username',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 240,
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
                          '$publishDate',
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                      onPressed: () {},
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
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 0),
            //   child: Row(
            //     children: <Widget>[
            //       Text(
            //         'Status: ',
            //         style: const TextStyle(
            //           fontSize: 16.0,
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       Text(
            //         '$status',
            //         style: const TextStyle(
            //           fontSize: 16.0,
            //           color: Colors.black,
            //         ),
            //       ),
            //       Spacer(),
            //       ButtonTheme(
            //         height: 30,
            //         minWidth: 90,
            //         child: RaisedButton(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(40.0),
            //           ),
            //           onPressed: () {},
            //           color: Color.fromARGB(255, 58, 137, 193),
            //           child: Text(
            //             'Ver Projeto',
            //             style: TextStyle(
            //               fontSize: 16,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //),
          ],
        ),
      ),
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.image,
    this.username,
    this.publishDate,
    this.title,
    this.notification,
    this.status,
  }) : super(key: key);

  final String image;
  final String username;
  final String publishDate;
  final String title;
  final String notification;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _NotificationItem(
                image: image,
                username: username,
                publishDate: publishDate,
                title: title,
                notification: notification,
                status: status,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
      children: <Widget>[
        CustomListItemTwo(
          image: 'assets/images/person76.jpeg',
          username: 'Guilherme L.Fernandez',
          publishDate: '01/05/2020 às 14:00',
          title: 'TCC - InovConnect',
          notification: 'Solicitou a entrada no seu projeto',
          status: 'Pendente',
        ),
        CustomListItemTwo(
          image: 'assets/images/person76.jpeg',
          username: 'Guilherme L.Fernandez',
          publishDate: '01/05/2020 às 14:00',
          title: 'TCC - InovConnect',
          notification: 'Solicitou a entrada no seu projeto',
          status: 'Pendente',
        ),
      ],
    );
  }
}
