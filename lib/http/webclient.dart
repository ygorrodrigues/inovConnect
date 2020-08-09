import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(interceptors: [
  LoggingInterceptor()
]);

const String url = 'http://192.168.0.8:3000';
const String all_posts_url = '$url/posts';
const String filtered_posts_url = '$url/posts/filter';
const String login_url = '$url/users/login';
const String first_auth_url = '$url/users/auth';
const String registration_url = '$url/users/register';
const String list_courses_url = '$url/courses';
const String list_types_url = '$url/types';
const String list_categories_url = '$url/categories';
const String reset_password_url = '$url/resetpass';
const String add_member_url = '$url/members';
const String add_post_with_category_url = '$url/posts/new-category';
