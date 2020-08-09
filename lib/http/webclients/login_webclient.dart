import 'dart:convert';
import 'dart:io';
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
          throw Exception('Tente novamente mais tarde');
        });

    Map<String, dynamic> resp = jsonDecode(response.body);
    try{
      await storage.write(key: 'token', value: resp['accessToken']);
      return resp;
    }
    catch(e){
      throw Exception(resp['message']);
    }
  }

  Future<void> tokenValidation() async {
    String token = await storage.read(key: 'token');
    if(token != null) {
      final Response response = 
      await client.get(first_auth_url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token'
      })
        .timeout(Duration(seconds: 5))
        .catchError((err){
          print('Erro ao contactar o servidor');
        });

      if(response.statusCode == 401) {
        throw Exception('Sessão finalizada');
      }
    }
    else {
      throw Exception('No token found');
    }
  }

  Future<void> removeToken() async {
    print('Deletando key');
    return await storage.delete(key: 'token');
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    final String emailJson = jsonEncode({
      'email': email,
    });
    final Response response =
      await client.post(
        reset_password_url, 
        headers: {
          'Content-type': 'application/json'
        },
        body: emailJson
      )
        .timeout(Duration(seconds: 5)).catchError((err) {
          throw Exception('Tente novamente mais tarde');
        });

    Map<String, dynamic> resp = jsonDecode(response.body);
    try{
      return resp;
    }
    catch(e){
      throw Exception(resp['message']);
    }
  }

}