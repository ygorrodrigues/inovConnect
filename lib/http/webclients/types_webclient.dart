import 'dart:convert';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class TypesWebClient {
  Future<List<Map>> listTypes() async {
    final Response response =
      await client.get(list_types_url)
        .timeout(Duration(seconds: 5)).catchError((err) {
          throw Exception('Tente novamente mais tarde');
        });
    try{
      List<dynamic> resp = jsonDecode(response.body);
      List<Map> types = resp.map((type) {
        return {
          'id': type['id'],
          'name': type['name']
          };
      }).toList();
      return types;
    }
    catch(e) {
      throw Exception(e);
    }
  }
}