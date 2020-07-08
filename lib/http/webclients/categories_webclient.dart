import 'dart:convert';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class CategoriesWebClient {
  Future<List<Map>> listCategories() async {
    final Response response =
      await client.get(list_categories_url)
        .timeout(Duration(seconds: 5)).catchError((err) {
          throw Exception('Tente novamente mais tarde');
        });
    try{
      List<dynamic> resp = jsonDecode(response.body);
      List<Map> categories = resp.map((category) {
        return {
          'id': category['id'],
          'name': category['name']
          };
      }).toList();
      return categories;
    }
    catch(e) {
      throw Exception(e);
    }
  }
}