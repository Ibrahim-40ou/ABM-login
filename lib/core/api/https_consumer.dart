import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../core/utils/result.dart';
import 'endpoints.dart';

class HttpsConsumer {
  final String baseUrl = EndPoints.baserUrl;

  Future<Result<void>> postRequest({
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
            },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return Result<void>(data: null);
      } else {
        return Result<void>(error: 'Failed to post: ${response.body}');
      }
    } catch (e) {
      return Result<void>(error: e.toString());
    }
  }
}
