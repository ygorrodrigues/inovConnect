import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';
import 'package:inov_connect/models/post_projeto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostsWebClient{

  Future<List<PostProjeto>> findAll() async{

    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    final Response response =
      await client.get(
        allPosts_url,
        headers: { HttpHeaders.authorizationHeader: 'Bearer $token' }
      )
        .timeout(Duration(seconds: 5))
        .catchError((err){
          print('Erro -> err');
        });
        
    final List<dynamic> data = jsonDecode(response.body);
    final List<PostProjeto> posts = data
      .map((dynamic json) => PostProjeto.fromJson(json)).toList();
    print(posts);
    return posts;
  }

  Future<PostProjeto> save(PostProjeto postProjeto) async{
    final String postProjetoJson = jsonEncode(postProjeto.toJson());
    final Response response = await client.post(allPosts_url, headers: {
      'Content-type': 'application/json'
      },
      body: postProjetoJson
    );
    PostProjeto post = PostProjeto.fromJson(jsonDecode(response.body)['data']);
    return post;
  }

}