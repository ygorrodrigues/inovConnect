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
    final Response response = await client.post(add_member_url,
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: postJson);
    try {
      Map<String, dynamic> resp = jsonDecode(response.body);
      return resp;
    }
    catch(e) {
      throw Exception(e);
    }
  }
}
