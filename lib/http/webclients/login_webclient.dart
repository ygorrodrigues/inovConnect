import 'dart:convert';

import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class LoginWebClient{

  Future<Map<String, dynamic>> createToken(String user, String pwd) async{
    final String userDataJson = jsonEncode({
      'user': user,
      'pwd': pwd
    });
    final Response response = 
      await client.post(login_url, headers: {
      'Content-type': 'application/json'
      },
      body: userDataJson
    ).timeout(Duration(seconds: 5)).catchError((err) {
      print("Erro -> $err");
    });

    try{
      Map<String, dynamic> resp = jsonDecode(response.body);

      return resp;
    }
    catch(e){
      return {'message': 'Erro desconhecido'};
    }    
  }

}