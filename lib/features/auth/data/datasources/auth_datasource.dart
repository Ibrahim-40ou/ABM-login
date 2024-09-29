import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/utils/result.dart';

class AuthDatasourece {
  final String baseUrl = 'http://57.129.46.137/api/v1/auth/';

  Future<Result<void>> sendOTP(String phoneNumber) async {
    try {
      var response = await http.post(
        Uri.parse('${baseUrl}send_otp'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'phone': phoneNumber,
          },
        ),
      );
      if (response.statusCode == 200) {
        return Result<void>(data: null);
      } else {
        return Result<void>(error: 'Failed to send OTP: ${response.body}');
      }
    } catch (e) {
      return Result<void>(error: e.toString());
    }
  }

  Future<Result<void>> login(String phoneNumber, String otp) async {
    try {
      var response = await http.post(
        Uri.parse('${baseUrl}login'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "phone": phoneNumber,
            "otp": otp,
          },
        ),
      );
      if (response.statusCode == 200) {
        return Result<void>(data: null);
      } else {
        return Result<void>(error: 'Failed to send OTP: ${response.body}');
      }
    } catch (e) {
      return Result<void>(error: e.toString());
    }
  }
}
