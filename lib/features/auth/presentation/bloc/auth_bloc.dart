import 'package:abm_login/features/auth/data/datasources/auth_datasource.dart';
import 'package:abm_login/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:abm_login/features/auth/domain/use_cases/login_usecase.dart';
import 'package:abm_login/features/auth/domain/use_cases/send_otp_usecase.dart';
import 'package:abm_login/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/result.dart';

part 'auth_events.dart';

part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SendOTP>(_sendOTP);
    on<LoginRequest>(_login);
    on<LogoutRequest>(_logout);
  }

  Future<void> _sendOTP(SendOTP event, Emitter<AuthState> emit) async {
    final Result result = await SendOTPUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasourece(),
      ),
    ).call(event.phoneNumber);
    if(result.isSuccess) {
      return emit(SendOTPSuccess());
    } else {
      return emit(SendOTPFailure(failure: result.error));
    }
  }

  Future<void> _login(LoginRequest event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    final Result result = await LoginUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasourece(),
      ),
    ).call(event.phoneNumber, event.otp);
    if(result.isSuccess) {
      loginCheck!.setBool('loggedIn', true);
      return emit(LoginSuccess());
    } else {
      return emit(LoginFailure(failure: result.error));
    }
  }

  Future<void> _logout(LogoutRequest event, Emitter<AuthState> emit) async {
    emit(LogoutLoading());
    loginCheck!.clear();
    emit(LogoutSuccess());
  }
}
