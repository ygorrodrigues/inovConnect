import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inov_connect/components/centered_message.dart';
import 'package:inov_connect/components/progress.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';
import 'package:inov_connect/http/webclients/user_webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:inov_connect/screens/posts/feed_item.dart';
import 'package:inov_connect/screens/posts/form.dart';
import 'package:inov_connect/screens/users/edit_profile.dart';
import 'package:inov_connect/screens/users/signin.dart';

final LoginWebClient _loginWebClient = LoginWebClient();

class Profile extends StatefulWidget {
  final UserWebClient _userWebClient = UserWebClient();
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> _userData;
  List<dynamic> _userParticipations;
  int _nProjects;
  int _nStudyGroups;
  int _nDoubts;
  List<Post> _userPosts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: FutureBuilder<Map<String, dynamic>>(
        future: widget._userWebClient.listUserData(),
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
              if(snapshot.hasData) {
                _userData = snapshot.data['userData'];
                _userParticipations = snapshot.data['userParticipation'];

                List<dynamic> posts = _userData['posts'];
                _userPosts = posts
                  .map((dynamic json) => Post.fromJson(json)).toList();

                _nProjects = _countParticipations('Projeto');
                _nStudyGroups = _countParticipations('Grupo de estudo');
                _nDoubts = _countParticipations('Dúvida');

                if(_userPosts.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      if(index == 0) {
                        return UserInformation(
                          userInfo: _userData,
                          projects: _nProjects,
                          studyGroups: _nStudyGroups,
                          doubts: _nDoubts,
                        );
                      }
                      final Post post = _userPosts[index - 1];
                      return FeedItem(post, _userData['id']);
                    },
                    itemCount: _userPosts.length + 1,
                  );
                }
                return Container(
                  child: Text('Você não possui projetos ainda...')
                );
              }
              break;
          }
          return CenteredMessage('Alguma falha ocorreu', icon: Icons.close);
        }
      )
    );
  }

  int _countParticipations(String keyword) {
    int count = 0;
    for(Map<String, dynamic> participation in _userParticipations) {
      if(participation['post'] != null) {
        if(participation['post']['type']['name'] == keyword) {
          count++;
        }
      }
    }
    for(Map<String, dynamic> post in _userData['posts']) {
      if(post['type']['name'] == keyword && post['post_status']['name'] == 'Concluído') {
        count++;
      }
    }
    return count;
  }
}

class UserInformation extends StatelessWidget {
  final Map<String, dynamic> userInfo;
  final int projects;
  final int studyGroups;
  final int doubts;
  const UserInformation({
    this.userInfo,
    this.projects,
    this.studyGroups,
    this.doubts
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditProfile(
                            name: userInfo['name'],
                            description: userInfo['description'],
                            courseId: userInfo['course']['id'],
                          )));
                      },
                      child: Text(
                        'Editar',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.lightBlue[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _loginWebClient.removeToken().then((response) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Signin();
                          }));
                        });
                      },
                      child: Text(
                        'Sair',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.lightBlue[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(68.0),
                    ),
                    child: Image.asset(
                      'assets/images/person128.jpg',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      userInfo['name'],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.lightBlue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                  child: Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Curso:',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.lightBlue[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                        child: Text(
                          userInfo['course']['name'],
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 142, 142, 142),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 4.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: RichText(
                            text: TextSpan(
                              text: 'Descrição: ',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.lightBlue[400],
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: userInfo['description'],
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(255, 142, 142, 142),
                                    fontWeight: FontWeight.normal
                                  )
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                          text: TextSpan(
                            text: 'Atividades concluídas:\n',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.lightBlue[400],
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'Projetos: $projects\n',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 142, 142, 142),
                                  fontWeight: FontWeight.normal
                                )
                              ),
                              TextSpan(
                                text: 'Dúvidas: $doubts\n',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 142, 142, 142),
                                  fontWeight: FontWeight.normal
                                )
                              ),
                              TextSpan(
                                text: 'Grupos de estudo: $studyGroups',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 142, 142, 142),
                                  fontWeight: FontWeight.normal
                                )
                              ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: RaisedButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0)
            ),
            child: Text(
              'Criar publicação',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue[400]
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => FormPost()));
            }
          ),
        ),
      ],
    );
  }
}
