// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';
import 'package:inov_connect/screens_dev/perfil/login.dart';
import 'package:inov_connect/screens_dev/projetos/feed.dart';

void main() => runApp(InovConnect());

class InovConnect extends StatelessWidget {

  final LoginWebClient _webClient = LoginWebClient();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _webClient.tokenValidation(),
      builder: (context, response) {
        if(response.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.grey[50],
            ),
            home: Login(),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[50],
          ),
          home: ProjectsFeed(),
        );
      }
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(
  //       scaffoldBackgroundColor: Colors.grey[50],
  //     ),
  //     home: Login(),
  //   );
  // }
}
