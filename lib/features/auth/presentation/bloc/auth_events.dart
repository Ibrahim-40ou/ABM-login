part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SendOTPRequest extends AuthEvent {
  final String phoneNumber;

  SendOTPRequest({required this.phoneNumber});
}

class LoginRequest extends AuthEvent {
  final String phoneNumber;
  final String otp;

  LoginRequest({required this.phoneNumber, required this.otp});
}

class LogoutRequest extends AuthEvent {}

class RegisterRequest extends AuthEvent {
  final String fullName;
  final String phoneNumber;

  RegisterRequest({
    required this.fullName,
    required this.phoneNumber,
  });
}

class PickImageRequest extends AuthEvent {
  final XFile? selectedImage;

  PickImageRequest({required this.selectedImage});
}

class GetCurrentUserEvent extends AuthEvent {}

class UpdateProfileRequest extends AuthEvent {
  final String fullName;

  UpdateProfileRequest({required this.fullName});
}
