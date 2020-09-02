import 'package:flutter/material.dart';
import 'package:inov_connect/components/centered_message.dart';
import 'package:inov_connect/components/progress.dart';
import 'package:inov_connect/http/webclients/user_webclient.dart';

class OtherProfile extends StatefulWidget {
  final int otherUserId;
  const OtherProfile({
    this.otherUserId
  });
  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  final UserWebClient _userWebClient = UserWebClient();
  Map<String, dynamic> _userData;
  List<dynamic> _userParticipations;
  int _nProjects;
  int _nStudyGroups;
  int _nDoubts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userWebClient.listOtherUserData(widget.otherUserId),
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

                _nProjects = _countParticipations('Projeto');
                _nStudyGroups = _countParticipations('Grupo de estudo');
                _nDoubts = _countParticipations('Dúvida');

                if(_userData.isNotEmpty) {
                  return OtherUserInformation(
                    userInfo: _userData,
                    projects: _nProjects,
                    studyGroups: _nStudyGroups,
                    doubts: _nDoubts,
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
      if(post['type']['name'] == keyword) {
        count++;
      }
    }
    return count;
  }
}

class OtherUserInformation extends StatelessWidget {
  final Map<String, dynamic> userInfo;
  final int projects;
  final int studyGroups;
  final int doubts;
  const OtherUserInformation({
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
          margin: EdgeInsets.only(
            top: 25,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
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
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                //   child: Row(
                //     children: <Widget>[
                //       Align(
                //         alignment: Alignment.bottomLeft,
                //         child: Text(
                //           'Semestre:',
                //           style: TextStyle(
                //             fontSize: 16.0,
                //             color: Colors.lightBlue[400],
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                //         child: Text(
                //           '10º',
                //           style: TextStyle(
                //             fontSize: 14.0,
                //             color: Color.fromARGB(255, 142, 142, 142),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
      ],
    );
  }
}