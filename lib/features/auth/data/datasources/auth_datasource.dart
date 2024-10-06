import 'dart:convert';

import 'package:abm_login/main.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/api/https_consumer.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class AuthDatasource {
  final HttpsConsumer httpsConsumer;

  AuthDatasource({
    required this.httpsConsumer,
  });

  Future<Result<void>> sendOTP(
    String phoneNumber,
  ) async {
    final result = await httpsConsumer.postRequest(
      endpoint: EndPoints.sendOTP,
      body: {
        'phone': phoneNumber,
      },
    );
    if (result.isSuccess && result.data != null) {
      return Result<void>(data: null);
    } else {
      return Result<void>(error: result.error);
    }
  }

  Future<Result<void>> login(String phoneNumber, String otp) async {
    final result = await httpsConsumer.postRequest(
      endpoint: EndPoints.login,
      body: {
        'phone': phoneNumber,
        'otp': otp,
      },
    );

    if (result.isSuccess && result.data != null) {
      final response = result.data!;
      final responseBody = jsonDecode(response.body);

      final String? accessToken = responseBody['access_token'];
      if (accessToken != null) {
        await accessTokenPreferences!.setString('token', accessToken);
      }
      return Result<void>(data: null);
    } else {
      return Result<void>(error: result.error);
    }
  }

  Future<Result<void>> register(
    String fullName,
    String phoneNumber,
  ) async {
    final result = await httpsConsumer.postRequest(
      endpoint: EndPoints.register,
      body: {
        'name': fullName,
        'phone': phoneNumber,
      },
    );

    if (result.isSuccess && result.data != null) {
      return Result<void>(data: null);
    } else {
      return Result<void>(error: result.error);
    }
  }

  Future<Result<UserEntity>> fetchCurrentUser() async {
    final result = await httpsConsumer.getRequest(endpoint: EndPoints.me);
    if (result.isSuccess && result.data != null) {
      final responseBody = jsonDecode(result.data!.body);

      final user = UserModel.fromJson(responseBody);

      return Result<UserEntity>(data: user);
    } else {
      return Result<UserEntity>(error: result.error);
    }
  }

  Future<Result<void>> updateUserInformation(
    String fullName,
  ) async {
    try {
      await httpsConsumer.putRequest(
        endpoint: EndPoints.profile,
        body: {
          'name': fullName,
        },
      );
      return Result<void>(data: null);
    } on Exception catch (e) {
      return Result<void>(error: '$e');
    }
  }
}
