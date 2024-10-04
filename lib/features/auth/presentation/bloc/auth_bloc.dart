import 'package:abm_login/features/auth/data/datasources/auth_datasource.dart';
import 'package:abm_login/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:abm_login/features/auth/domain/use_cases/login_usecase.dart';
import 'package:abm_login/features/auth/domain/use_cases/register_usecase.dart';
import 'package:abm_login/features/auth/domain/use_cases/send_otp_usecase.dart';
import 'package:abm_login/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/api/https_consumer.dart';
import '../../../../core/utils/result.dart';

part 'auth_events.dart';

part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SendOTPRequest>(_sendOTP);
    on<LoginRequest>(_login);
    on<LogoutRequest>(_logout);
    on<ChangeTheme>(_changeTheme);
    on<LoadTheme>(_loadTheme);
    on<PickImageRequest>(_pickImage);
    on<RegisterRequest>(_register);
  }

  Future<void> _register(
    RegisterRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(RegisterLoading());
    final Result result = await RegisterUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasource(
          httpsConsumer: HttpsConsumer(),
        ),
      ),
    ).call(
      event.fullName,
      event.phoneNumber,
    );
    if (result.isSuccess) {
      return emit(RegisterSuccess());
    } else {
      return emit(RegisterFailure(failure: result.error));
    }
  }

  Future<void> _pickImage(
    PickImageRequest event,
    Emitter<AuthState> emit,
  ) async {
    return emit(PickImageSuccess(selectedImage: event.selectedImage));
  }

  void _loadTheme(LoadTheme event, Emitter<AuthState> emit) {
    emit(ThemeChanged(isDarkMode: event.isDarkMode));
  }

  void _changeTheme(ChangeTheme event, Emitter<AuthState> emit) {
    darkModeCheck?.setBool('isDarkMode', event.isDarkMode);
    emit(ThemeChanged(isDarkMode: event.isDarkMode));
  }

  Future<void> _sendOTP(SendOTPRequest event, Emitter<AuthState> emit) async {
    final Result result = await SendOTPUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasource(
          httpsConsumer: HttpsConsumer(),
        ),
      ),
    ).call(event.phoneNumber);
    if (result.isSuccess) {
      return emit(SendOTPSuccess());
    } else {
      return emit(SendOTPFailure(failure: result.error));
    }
  }

  Future<void> _login(LoginRequest event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    final Result result = await LoginUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasource(
          httpsConsumer: HttpsConsumer(),
        ),
      ),
    ).call(event.phoneNumber, event.otp);
    if (result.isSuccess) {
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
