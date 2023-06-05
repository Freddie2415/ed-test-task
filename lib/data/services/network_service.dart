import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class NetworkService {
  late String baseUrl;

  dynamic get({required String path, Map<String, dynamic>? params});

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? data,
  });
}

class HttpNetworkService implements NetworkService {
  @override
  late String baseUrl;

  HttpNetworkService(this.baseUrl);

  @override
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? params,
  }) async {
    final response = await http.get(Uri.parse('$baseUrl$path'));
    return json.decode(response.body);
  }

  @override
  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    final url = Uri.parse('$baseUrl$path');
    final response = await http.post(
      url,
      body: data,
    );

    return json.decode(response.body);
  }
}
