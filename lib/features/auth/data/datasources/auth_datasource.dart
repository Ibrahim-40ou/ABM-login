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
      print('hey1');
      if (response.statusCode == 200) {
        print('hey2');
        return Result<void>(data: null);
      } else {
        print('hey3');
        print(response.body);
        return Result<void>(error: 'Failed to send OTP: ${response.body}');
      }
    } catch (e) {
      print('hey4');
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
      print('hey5');
      if (response.statusCode == 200) {
        print('hey6');
        return Result<void>(data: null);
      } else {
        print('hey7');
        print(response.body);
        return Result<void>(error: 'Failed to send OTP: ${response.body}');
      }
    } catch (e) {
      print('hey8');
      return Result<void>(error: e.toString());
    }
  }
}
