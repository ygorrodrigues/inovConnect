import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class MembersWebClient {
  Future<Map<String, dynamic>> addMember(int postId) async {
    final String postJson = jsonEncode({
      'post': postId.toString(),
    });
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    final Response response = await client.post(
      add_member_url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: postJson
    );
    try {
      Map<String, dynamic> resp = jsonDecode(response.body);
      return resp;
    }
    catch(e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> listNotifications() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    final Response response = await client.get(
      list_members_url,
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
      
    Map<String, dynamic> data = jsonDecode(response.body);
    try{
      return data;
    }
    catch(e){
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> listNewNotifications() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    final Response response = await client.get(
      list_notifications_url,
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
      
    Map<String, dynamic> data = jsonDecode(response.body);
    try{
      return data;
    }
    catch(e){
      throw Exception(e);
    }
  }

  Future<void> changeMemberStatus(int memberId, int newStatusId) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    final String changeMemberJson = jsonEncode({
      'member': memberId,
      'memberStatusId': newStatusId,
    });

    client.patch(
      update_members_url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: changeMemberJson
    )
      .timeout(Duration(seconds: 5))
      .catchError((err){
        print('Erro -> $err');
      });
  }

  Future<Map<String, dynamic>> listMembers(int postId) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    var uri = get_members_url + '?post=$postId';
    final Response response = await client.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    try {
      Map<String, dynamic> resp = jsonDecode(response.body);
      return resp;
    }
    catch(e) {
      throw Exception(e);
    }
  }

  Future<void> updateNotifications(List ownerNotifications, List memberNotifications) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    final String updateNotificationsJson = jsonEncode({
      'ownerNotifications': ownerNotifications,
      'memberNotifications': memberNotifications,
    });

    client.patch(
      update_notifications_url,
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
