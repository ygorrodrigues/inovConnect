import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract{
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('URL: ${data.baseUrl}');
    print('Headers: ${data.headers}');
    print('Request body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Status code: ${data.statusCode}');
    print('Response body: ${data.body}');
    return data;
  }
}