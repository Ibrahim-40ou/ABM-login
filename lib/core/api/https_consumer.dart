import 'package:abm_login/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../core/utils/result.dart';
import 'endpoints.dart';

class HttpsConsumer {
  final String baseUrl = EndPoints.baserUrl;

  Future<Result<http.Response>> postRequest({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ??
            {
              'accept': 'application/json',
              'Content-Type': 'application/json',
              'authorization':
                  "bearer ${accessTokenPreferences!.getString('token')}",
            },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return Result<http.Response>(data: response);
      } else {
        return Result<http.Response>(error: 'Failed to post: ${response.body}');
      }
    } catch (e) {
      return Result<http.Response>(error: e.toString());
    }
  }

  Future<Result<http.Response>> putRequest({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ??
            {
              'accept': 'application/json',
              'Content-Type': 'application/json',
              'authorization':
                  "bearer ${accessTokenPreferences!.getString('token')}",
            },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return Result<http.Response>(data: response);
      } else {
        return Result<http.Response>(error: 'Failed to post: ${response.body}');
      }
    } catch (e) {
      return Result<http.Response>(error: e.toString());
    }
  }

  Future<Result<http.Response>> getRequest({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ??
            {
              'accept': 'application/json',
              'Content-Type': 'application/json',
              'authorization':
                  "bearer ${accessTokenPreferences!.getString('token')}",
            },
      );
      if (response.statusCode == 200) {
        return Result<http.Response>(data: response);
      } else {
        return Result<http.Response>(error: 'Failed to post: ${response.body}');
      }
    } catch (e) {
      return Result<http.Response>(error: e.toString());
    }
  }
}
