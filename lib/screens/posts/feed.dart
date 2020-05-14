import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  const Feed({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatelessWidget(),
    );
  }
}

class _FeedItem extends StatelessWidget {
  _FeedItem({
    Key key,
    this.colorCard,
    this.image,
    this.type,
    this.username,
    this.publishDate,
    this.title,
    this.category,
  }) : super(key: key);

  final Color colorCard;
  final String image;
  final String type;
  final String username;
  final String publishDate;
  final String title;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
      ),
      color: colorCard,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(
                  '$type',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                      child: Text(
                        '$username',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                      child: Text(
                        '$publishDate',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Color.fromARGB(255, 69, 90, 100),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 6.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Título: ',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 6.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Categoria: ',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$category',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
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
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.colorCard,
    this.image,
    this.type,
    this.username,
    this.publishDate,
    this.title,
    this.category,
  }) : super(key: key);

  final Color colorCard;
  final String image;
  final String type;
  final String username;
  final String publishDate;
  final String title;
  final String category;

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
              child: _FeedItem(
                colorCard: colorCard,
                image: image,
                type: type,
                username: username,
                publishDate: publishDate,
                title: title,
                category: category,
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
          colorCard: Colors.red[400],
          image: 'assets/images/person64.jpg',
          type: 'PROJETO',
          username: 'Guilherme',
          publishDate: '01/05/2020 às 14:00',
          title: 'TCC - InovConnect',
          category: 'Hardware',
        ),
        CustomListItemTwo(
          colorCard: Colors.lightBlue[400],
          image: 'assets/images/person64.jpg',
          type: 'DÚVIDA',
          username: 'Guilherme',
          publishDate: '01/05/2020 às 14:00',
          title: 'TCC - InovConnect',
          category: 'Hardware',
        ),
        CustomListItemTwo(
          colorCard: Colors.green[400],
          image: 'assets/images/person64.jpg',
          type: 'GRUPO DE ESTUDOS',
          username: 'Guilherme',
          publishDate: '01/05/2020 às 14:00',
          title: 'TCC - InovConnect',
          category: 'Hardware',
        ),
        CustomListItemTwo(
          colorCard: Colors.red[400],
          image: 'assets/images/person64.jpg',
          type: 'PROJETO',
          username: 'Guilherme',
          publishDate: '01/05/2020 às 14:00',
          title: 'TCC - InovConnect',
          category: 'Hardware',
        ),
      ],
    );
  }
}