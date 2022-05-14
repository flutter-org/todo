import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:todo/model/todo.dart';

const Map<String, String> commonHeaders = {'Content-Type': 'application/json'};
final String baseUrl = Platform.isAndroid ? 'http://10.0.2.2:8989' : 'http://localhost:8989';

/// 单例对象
class NetworkClient {
  NetworkClient._();

  static final NetworkClient _client = NetworkClient._();

  factory NetworkClient.instance() => _client;

  Future<String> login(String email, String password) async {
    Map result = {};
    try {
      Response response = await post(
        Uri.parse('$baseUrl/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: commonHeaders,
      );
      result = const JsonDecoder().convert(response.body);
    } catch (e) {
      result['error'] = '登录失败\n 错误信息为 $e';
    }
    return result['error'];
  }

  Future<String> uploadList(List<Todo> list, String userKey) async {
    Map result = {};
    try {
      Response response = await post(
        Uri.parse('$baseUrl/list'),
        body: const JsonEncoder().convert({
          'userKey': userKey,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'data': list.map((todo) => todo.toMap()).toList(),
        }),
        headers: {'Content-Type': 'application/json'},
      );
      result = const JsonDecoder().convert(response.body);
    } catch (e) {
      result['error'] = '服务器请求失败, 请检查网络链接';
    }
    return result['error'];
  }

  Future<FetchListResult> fetchList(String userKey) async {
    FetchListResult result;
    try {
      Response response = await get(Uri.parse('$baseUrl/list?userKey=$userKey'), headers: commonHeaders);
      result = FetchListResult.fromJson(const JsonDecoder().convert(response.body));
    } catch (e) {
      result = FetchListResult(error: '服务器请求失败,请检查网络链接');
    }
    return result;
  }
}

class FetchListResult {
  final List<Todo>? data;
  final DateTime? timestamp;
  final String error;

  FetchListResult({this.data, this.timestamp, this.error = ''});

  factory FetchListResult.fromJson(Map<dynamic, dynamic> json) {
    return FetchListResult(
      data: json['data']['data'].map<Todo>((e) => Todo.fromMap(e)).toList(),
      timestamp: DateTime.fromMicrosecondsSinceEpoch(json['data']['timestamp']),
    );
  }
}
