import 'dart:convert';
import 'package:http/http.dart';
import 'package:inov_connect/http/webclient.dart';

class SignupWebClient {
  Future<String> registerUser(String name, String email, 
    String pwd, String ra, String course) async {
      if(!isNumeric(course))
        throw Exception('Selecione o seu curso.');

      final String userDataJson = jsonEncode({
        'name': name,
        'email': email,
        'password': pwd,
        'raCode': ra,
        'courseId': int.parse(course)
      });
      final Response response =
        await client.post(registration_url, headers: {
          'Content-type': 'application/json'
        },
        body: userDataJson
        )
        .timeout(Duration(seconds: 5)).catchError((err) {
          throw Exception('Tente novamente mais tarde');
        });

      try{
        Map<String, dynamic> resp = jsonDecode(response.body);
        return resp['name'];
      }
      catch(e) {
        throw Exception(e);
      }
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

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