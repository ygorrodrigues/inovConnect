import 'dart:convert';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class TypesAndCategoriesWebClient {
  Future<Map<String, List<Map>>> listTypesAndCategories() async {
    final Response response =
      await client.get(list_types_and_categories_url)
        .timeout(Duration(seconds: 5)).catchError((err) {
          throw Exception('Tente novamente mais tarde');
        });
    try{
      Map<String, dynamic> resp = jsonDecode(response.body);

      List<dynamic> typesMap = resp['types'];
      List<Map> types = typesMap.map((type) {
        return {
          'id': type['id'],
          'name': type['name']
          };
      }).toList();

      List<dynamic> categoriesMap = resp['categories'];
      List<Map> categories = categoriesMap.map((category) {
        return {
          'id': category['id'],
          'name': category['name']
          };
      }).toList();

      return {
        'types': types,
        'categories': categories
      };
    }
    catch(e) {
      throw e;
    }
  }
}