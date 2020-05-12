import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(interceptors: [
  LoggingInterceptor()
]);

const String url = 'http://192.168.0.5:3000';
const String allPosts_url = '$url/posts';
const String login_url = '$url/users/login';