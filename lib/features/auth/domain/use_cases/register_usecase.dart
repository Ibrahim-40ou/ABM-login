import 'package:abm_login/core/utils/result.dart';
import 'package:abm_login/features/auth/data/repositories/auth_repository_impl.dart';

class RegisterUseCase {
  final AuthRepositoryImpl authRepositoryImpl;

  RegisterUseCase({required this.authRepositoryImpl});

  Future<Result<void>> call(String fullName, String phoneNumber) async {
    return await authRepositoryImpl.register(fullName, phoneNumber);
  }
}
