import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';
import 'package:inov_connect/models/post.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostsWebClient{

  Future<Map<String, dynamic>> findAll(int typeId, int categoryId, int pageN) async{
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    String type = typeId.toString();
    String category = categoryId.toString();
    String page = pageN.toString();

    var uri = filtered_posts_url + '?page=$page&type=$type&category=$category';
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

    if(response.statusCode > 300) {
      throw jsonDecode(response.body);
    }

    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  Future<Post> findOne(int postId) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    String uri = all_posts_url + '/id/$postId';
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
    final Post post = Post.fromJson(data.first);
    return post;
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

  Future<void> saveNewPost(Map<String, dynamic> newPost) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    final String newPostJson = jsonEncode(newPost);
    if(newPost['anotherCategory'].length > 1) {
      final Response response = await client.post(
        add_post_with_category_url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: newPostJson
      )
      .timeout(Duration(seconds: 5)).catchError((err) {
        throw Exception('Tente novamente mais tarde');
      });

      if(response.statusCode > 300) {
        throw Exception(response.body);
      }
    }
    else {
      final Response response = await client.post(
        all_posts_url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: newPostJson
      )
      .timeout(Duration(seconds: 5)).catchError((err) {
        throw Exception('Tente novamente mais tarde');
      });

      if(response.statusCode > 300) {
        throw response.body;
      }
    }
  }

  Future<List<Map>> listPostStatuses() async {
    final Response response =
      await client.get(post_status_url)
        .timeout(Duration(seconds: 5)).catchError((err) {
          throw Exception('Tente novamente mais tarde');
        });
    try{
      List<dynamic> resp = jsonDecode(response.body);
      List<Map> statuses = resp.map((status) {
        return {
          'id': status['id'],
          'name': status['name']
          };
      }).toList();
      return statuses;
    }
    catch(e) {
      throw Exception(e);
    }
  }

  Future<void> updatePost(int postId, String description, String newStatus) async {
    if(!isNumeric(newStatus))
      throw 'Selecione o status.';
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    if(token != null) {
      final String updatedPostJson = jsonEncode({
        'description': description,
        'statusId': newStatus,
      });

      client.patch(
        all_posts_url + '/$postId',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: updatedPostJson
      )
      .catchError((e) => throw Exception(e));
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