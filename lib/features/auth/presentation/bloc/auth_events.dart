part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SendOTP extends AuthEvent {
  final String phoneNumber;

  SendOTP({required this.phoneNumber});
}

class LoginRequest extends AuthEvent {
  final String phoneNumber;
  final String otp;

  LoginRequest({required this.phoneNumber, required this.otp});
}

class LogoutRequest extends AuthEvent {}
