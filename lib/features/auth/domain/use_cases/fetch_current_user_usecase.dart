import 'package:abm_login/core/utils/result.dart';
import 'package:abm_login/features/auth/data/repositories/auth_repository_impl.dart';

class GetCurrentUserUseCase {
  final AuthRepositoryImpl authRepositoryImpl;

  GetCurrentUserUseCase({required this.authRepositoryImpl});

  Future<Result<void>> call() async {
    return await authRepositoryImpl.fetchCurrentUser();
  }
}
