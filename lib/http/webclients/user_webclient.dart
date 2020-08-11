import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class UserWebClient {
  Future<Map<String, dynamic>> listUser() async {
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
      final List<dynamic> resp = jsonDecode(response.body);
      Map<String, dynamic> userData = resp[0];
      try{
        return userData;
      }
      catch(e){
        throw Exception('Erro');
      }
    }
    else {
      throw Exception('Erro de autenticação');
    }
  }
}