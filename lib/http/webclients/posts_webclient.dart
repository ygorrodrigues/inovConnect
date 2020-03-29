import 'dart:convert';

import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';
import 'package:inov_connect/models/post_projeto.dart';

class PostsWebClient{

  Future<List<PostProjeto>> findAll() async{
    final Response response =
      await client.get(posts_url).timeout(Duration(seconds: 5))
      .catchError((err){
        print('Erro -> err');
      });
    final List<dynamic> data = jsonDecode(response.body)['data'];
    final List<PostProjeto> posts = data
      .map((dynamic json) => PostProjeto.fromJson(json)).toList();
    return posts;
  }

  Future<PostProjeto> save(PostProjeto postProjeto) async{
    final String postProjetoJson = jsonEncode(postProjeto.toJson());
    final Response response = await client.post(posts_url, headers: {
      'Content-type': 'application/json'
      },
      body: postProjetoJson
    );
    PostProjeto post = PostProjeto.fromJson(jsonDecode(response.body)['data']);
    return post;
  }

}