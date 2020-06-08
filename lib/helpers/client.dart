import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Client {
  static httpGet(
    String url,
  ) {}

  static Future<http.Response> httpPost(String url,
      [dynamic data, String token]) async {
    return http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: token != null ? "Bearer $token" : null,
      },
      body: data ?? null,
    );
  }
}
