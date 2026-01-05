import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import 'api_exception.dart';

class ApiClient {
  final http.Client _client = http.Client();
  String? token;

  void setToken(String? value) {
    token = value;
  }

  Future<dynamic> get(String path) async {
    try {
      final response = await _client.get(Uri.parse('${AppConfig.baseUrl}$path'));
      return _processResponse(response);
    } on SocketException {
      throw NetworkException();
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${AppConfig.baseUrl}$path'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 401:
        throw UnauthorizedException();
      case 404:
        throw NotFoundException();
      default:
        throw ServerException(response.statusCode);
    }
  }
}
