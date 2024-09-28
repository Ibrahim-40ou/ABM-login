import 'package:abm_login/core/utils/result.dart';
import 'package:abm_login/features/auth/data/repositories/auth_repository_impl.dart';

class SendOTPUseCase {
  final AuthRepositoryImpl authRepositoryImpl;

  SendOTPUseCase({required this.authRepositoryImpl});

  Future<Result<void>> call(String phoneNumber) async {
    return await authRepositoryImpl.sendOTP(phoneNumber);
  }
}
