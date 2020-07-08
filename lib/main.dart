import 'package:flutter/material.dart';
import 'package:inov_connect/components/entry_loading.dart';
import 'package:inov_connect/http/webclients/login_webclient.dart';
import 'package:inov_connect/screens_dev/bottom/bottom_template.dart';
import 'package:inov_connect/screens_dev/users/signin.dart';

void main() => runApp(InovConnect());

class InovConnect extends StatelessWidget {

  final LoginWebClient _webClient = LoginWebClient();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _webClient.tokenValidation(),
      builder: (context, response) {
        switch(response.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return MaterialApp (home: EntryLoading());
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            if(response.hasError) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.grey[50],
                ),
                home: Signin()
              );
            } 
            else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.grey[50],
                ),
                home: BottomTemplate()
              );
            }
            break;
        }
          return Signin();
      }
    );
  }
}