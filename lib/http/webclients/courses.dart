import 'dart:convert';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class CoursesWebClient {
  Future<List<Map>> listCourses() async {
    final Response response =
      await client.get(list_courses_url)
        .timeout(Duration(seconds: 5)).catchError((err) {
          throw Exception('Tente novamente mais tarde');
        });
    try{
      List<dynamic> resp = jsonDecode(response.body);
      List<Map> courses = resp.map((course) {
        return {
          'id': course['id'],
          'name': course['name']
          };
      }).toList();
      return courses;
    }
    catch(e) {
      throw Exception(e);
    }
  }
}