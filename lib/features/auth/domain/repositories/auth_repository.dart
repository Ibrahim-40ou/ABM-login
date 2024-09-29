abstract class AuthRepository {
  Future<void> sendOTP(String phoneNumber);

  Future<void> login(String phoneNumber, String otp);
}
