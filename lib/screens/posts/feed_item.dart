import 'package:flutter/material.dart';
import 'package:inov_connect/models/post.dart';
import 'package:inov_connect/screens/posts/descpost.dart';
import 'package:inov_connect/screens/posts/descpost_profile.dart';

class FeedItem extends StatelessWidget {
  final Post postProjeto;
  final int yourId;
  final Function callback;
  const FeedItem(
    this.postProjeto,
    this.yourId,
    this.callback
  );
  final String image = 'assets/images/personIcon64.jpg';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(yourId != postProjeto.ownerId) {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => DescPost(postProjeto)));
        }
        else {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => DescPostProfile(postProjeto)))
            .then((value) => value == 'Ok' ? callback() : null);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        color: postProjeto.type == 'Projeto'
            ? Colors.red[400]
            : (postProjeto.type == 'Grupo de estudo'
                ? Colors.green[400]
                : Colors.blue[400]),
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
                    postProjeto.type,
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
                        image,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 4.0),
                          child: Text(
                            postProjeto.username,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                          child: Text(
                            postProjeto.creationDate,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 8.0, 0, 6.0),
                    child: Text(
                      'Título: ',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 8.0, 0, 6.0),
                      child: Text(
                        postProjeto.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 6.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Categorias:',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: _mountCategoriesString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal
                        )
                      ),
                    ]
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _mountCategoriesString() {
    String categories = ' ';
    for(int i = 0; i < postProjeto.categories.length; i++) {
      if(i != postProjeto.categories.length - 1)
        categories += postProjeto.categories[i]['name'] + ', ';
      else
        categories += postProjeto.categories[i]['name'];
    }
    return categories;
  }
}
