import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class ChatsWebClient {
  Future<List<dynamic>> listChats() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    final Response response = await client.get(
      list_chats_url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    )
      .timeout(Duration(seconds: 5))
        .catchError((err){
          print('Erro -> $err');
        });

    if(response.statusCode > 300) {
      throw jsonDecode(response.body);
    }
    
    List<dynamic> data = jsonDecode(response.body);
    try{
      return data;
    }
    catch(e){
      throw Exception('Erro');
    }
  }

  Future<Map<String, dynamic>> sendMessage(int chatId, String message, String role) async {
    final String messageJson = jsonEncode({
      'message': message,
      'role': role
    });
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    final Response response = await client.post(
      messages_url + '/$chatId',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: messageJson,
    )
      .timeout(Duration(seconds: 5))
      .catchError((err){
        print('Erro -> $err');
      });

    Map<String, dynamic> data = jsonDecode(response.body);
    try{
      return data;
    }
    catch(e){
      throw Exception('Erro');
    }
  }

  Future<List<dynamic>> listMessages(int chatId) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    final Response response = await client.get(
      messages_url + '/$chatId',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    )
      .timeout(Duration(seconds: 5))
      .catchError((err){
        print('Erro -> $err');
      });
    try {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    }
    catch(e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> listChatsNotifications() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    final Response response = await client.get(
      list_chats_notifications_url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    )
      .timeout(Duration(seconds: 5))
        .catchError((err){
          print('Erro -> $err');
        });

    if(response.statusCode > 300) {
      throw jsonDecode(response.body);
    }
    
    List<dynamic> data = jsonDecode(response.body);
    try{
      return data;
    }
    catch(e){
      throw Exception('Erro');
    }
  }
  
  Future<void> updateChatNotifications(String update, int chatId) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    final String updateNotificationsJson = jsonEncode({
      'chatId': chatId,
      'update': update
    });

    client.patch(
      update_chats_notifications_url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: updateNotificationsJson
    )
      .timeout(Duration(seconds: 5))
      .catchError((err){
        print('Erro -> $err');
      });
  }

}