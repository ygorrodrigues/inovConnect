import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostsWebClient{

  Future<List<Post>> findAll(int typeId, int categoryId) async{
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    String type = typeId.toString();
    String category = categoryId.toString();

    var uri = filtered_posts_url + '?type=$type&category=$category';
    final Response response =
      await client.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      )
        .timeout(Duration(seconds: 5))
        .catchError((err){
          print('Erro -> err');
        });
        
    final List<dynamic> data = jsonDecode(response.body);
    final List<Post> posts = data
      .map((dynamic json) => Post.fromJson(json)).toList();
    return posts;
  }

  Future<Post> save(Post postProjeto) async{
    final String postProjetoJson = jsonEncode(postProjeto.toJson());
    final Response response = await client.post(all_posts_url, headers: {
      'Content-type': 'application/json'
      },
      body: postProjetoJson
    );
    Post post = Post.fromJson(jsonDecode(response.body)['data']);
    return post;
  }

}