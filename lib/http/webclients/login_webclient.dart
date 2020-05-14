import 'dart:convert';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginWebClient{

  final storage = new FlutterSecureStorage();

  Future<Map<String, dynamic>> createToken(String user, String pwd) async{
    final String userDataJson = jsonEncode({
      'raCode': user,
      'password': pwd
    });
    final Response response = 
      await client.post(login_url, headers: {
      'Content-type': 'application/json'
      },
      body: userDataJson
      )
        .timeout(Duration(seconds: 5)).catchError((err) {
          print("Erro -> $err");
        });

    try{
      Map<String, dynamic> resp = jsonDecode(response.body);
      await storage.write(key: 'token', value: resp['accessToken']);
      return resp;
    }
    catch(e){
      return {'message': 'Erro $e'};
    }    
  }

  Future<String> tokenValidation() async {
    try {
      return await storage.read(key: 'token');
    } 
    catch (e) {
      return 'Erro $e';
    }
  }

  Future<void> removeToken() async {
    await storage.delete(key: 'token');
  }

}