import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class UserWebClient {
  Future<Map<String, dynamic>> listUserData() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    if(token != null) {
      final Response response = await client.get(
        user_info_url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        }
      );
      final Map<String, dynamic> resp = jsonDecode(response.body);
      try{
        return resp;
      }
      catch(e){
        throw Exception('Erro');
      }
    }
    else {
      throw Exception('Erro de autenticação');
    }
  }

  Future<void> updateUserData(String name, String description, String course) async {
    if(!isNumeric(course))
      throw Exception('Selecione o seu curso.');
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    if(token != null) {
      final String userDataJson = jsonEncode({
        'name': name,
        'description': description,
        'courseId': int.parse(course)
      });

      client.patch(
        user_info_url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: userDataJson
      )
      .catchError((e) => throw Exception(e));
    }
    else {
      throw Exception('Erro de autenticação');
    }
  }
  
  Future<Map<String, dynamic>> listOtherUserData(int otherUserId) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    if(token != null) {
      final Response response = await client.get(
        other_user_info_url + '/$otherUserId',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        }
      );
      final Map<String, dynamic> resp = jsonDecode(response.body);
      try{
        return resp;
      }
      catch(e){
        throw Exception('Erro');
      }
    }
    else {
      throw Exception('Erro de autenticação');
    }
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s) != null;
  }
}