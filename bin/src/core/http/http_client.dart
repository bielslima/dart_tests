import 'package:dio/dio.dart';

import '../consts/consts.dart';

class HttpClient {
  late final Dio client;

  HttpClient() {
    client = Dio(BaseOptions(baseUrl: AppConsts.apiUrl));
  }

  Future<Response> get(String url) {
    return client.get(url);
  }

  Future<Response> post(String url, [Map<String, dynamic>? data]) {
    return client.post(url, data: data ?? {});
  }

  Future<Response> put(String url, [Map<String, dynamic>? data]) {
    return client.put(url, data: data ?? {});
  }

  Future<Response> delete(String url) {
    return client.delete(url);
  }
}
