import 'package:abm_login/core/utils/result.dart';
import 'package:abm_login/features/auth/data/repositories/auth_repository_impl.dart';

class LoginUseCase {
  final AuthRepositoryImpl authRepositoryImpl;

  LoginUseCase({required this.authRepositoryImpl});

  Future<Result<void>> call(String phoneNumber, String otp) async {
    return await authRepositoryImpl.login(phoneNumber, otp);
  }
}
