import 'package:abm_login/core/utils/result.dart';
import 'package:abm_login/features/auth/data/datasources/auth_datasource.dart';
import 'package:abm_login/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasourece authDatasourece;

  AuthRepositoryImpl({required this.authDatasourece});

  @override
  Future<Result<void>> sendOTP(String phoneNumber) async {
    return await authDatasourece.sendOTP(phoneNumber);
  }

  @override
  Future<Result<void>> login(String phoneNumber, String otp) async {
    return await authDatasourece.login(phoneNumber, otp);
  }

  @override
  Future<Result<void>> register(String fullName, String phoneNumber) async {
    return await authDatasourece.register(fullName, phoneNumber);
  }
}
