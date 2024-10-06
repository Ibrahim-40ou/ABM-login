import 'package:abm_login/core/utils/result.dart';
import 'package:abm_login/features/auth/data/repositories/auth_repository_impl.dart';

class UpdateProfileUseCase {
  final AuthRepositoryImpl authRepositoryImpl;

  UpdateProfileUseCase({required this.authRepositoryImpl});

  Future<Result<void>> call(String fullName) async {
    return await authRepositoryImpl.updateUserInformation(fullName);
  }
}
