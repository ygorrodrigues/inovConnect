import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(interceptors: [
  LoggingInterceptor()
]);

const String url = 'https://inov-connect.herokuapp.com';
const String all_posts_url = '$url/posts';
const String filtered_posts_url = '$url/posts/filter';
const String login_url = '$url/users/login';
const String first_auth_url = '$url/users/auth';
const String registration_url = '$url/users/register';
const String list_courses_url = '$url/courses';
const String list_types_url = '$url/types';
const String list_categories_url = '$url/categories';
const String list_types_and_categories_url = '$url/types-and-categories';
const String reset_password_url = '$url/resetpass';
const String add_member_url = '$url/members';
const String add_post_with_category_url = '$url/posts/new-category';
const String user_info_url = '$url/user/profile';
const String list_members_url = '$url/members-status';
const String update_members_url = '$url/member-status-change';
const String list_chats_url = '$url/chats';
const String messages_url = '$url/messages';
const String post_status_url = '$url/posts-status';
const String other_user_info_url = '$url/other-user/profile';
const String get_members_url = '$url/members-of-post';
const String list_notifications_url = '$url/list-notifications';
const String update_notifications_url = '$url/notifications-seen-update';
const String list_chats_notifications_url = '$url/chats-notifications';
const String update_chats_notifications_url = '$url/chats-notifications-update';
