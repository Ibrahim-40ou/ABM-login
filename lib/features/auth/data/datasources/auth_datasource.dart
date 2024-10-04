
import '../../../../core/api/endpoints.dart';
import '../../../../core/api/https_consumer.dart';
import '../../../../core/utils/result.dart';

class AuthDatasource {
  final HttpsConsumer httpsConsumer;

  AuthDatasource({
    required this.httpsConsumer,
  });

  Future<Result<void>> sendOTP(String phoneNumber) {
    return httpsConsumer.postRequest(
      endpoint: EndPoints.sendOTP,
      body: {
        'phone': phoneNumber,
      },
    );
  }

  Future<Result<void>> login(String phoneNumber, String otp) {
    return httpsConsumer.postRequest(
      endpoint: EndPoints.login,
      body: {
        'phone': phoneNumber,
        'otp': otp,
      },
    );
  }

  Future<Result<void>> register(String fullName, String phoneNumber) {
    return httpsConsumer.postRequest(
      endpoint: EndPoints.register,
      body: {
        'name': fullName,
        'phone': phoneNumber,
      },
    );
  }
}
