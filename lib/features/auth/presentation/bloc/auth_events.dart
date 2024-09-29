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

class ChangeTheme extends AuthEvent {
  final bool isDarkMode;

  ChangeTheme({required this.isDarkMode});
}

class LoadTheme extends AuthEvent {
  final bool isDarkMode;

  LoadTheme({required this.isDarkMode});
}

