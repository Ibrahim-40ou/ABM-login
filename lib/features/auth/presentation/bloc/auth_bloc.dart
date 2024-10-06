import 'package:abm_login/features/auth/data/datasources/auth_datasource.dart';
import 'package:abm_login/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:abm_login/features/auth/domain/entities/user_entity.dart';
import 'package:abm_login/features/auth/domain/use_cases/fetch_current_user_usecase.dart';
import 'package:abm_login/features/auth/domain/use_cases/login_usecase.dart';
import 'package:abm_login/features/auth/domain/use_cases/register_usecase.dart';
import 'package:abm_login/features/auth/domain/use_cases/send_otp_usecase.dart';
import 'package:abm_login/features/auth/domain/use_cases/update_profile_usecase.dart';
import 'package:abm_login/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/api/https_consumer.dart';
import '../../../../core/utils/result.dart';

part 'auth_events.dart';

part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final UserEntity _initialUserInfo = UserEntity(
    name: '',
    phoneNumber: '',
    governorate: '',
    profilePicture: '',
  );
  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
  }

  AuthBloc() : super(AuthInitial()) {
    on<SendOTPRequest>(_sendOTP);
    on<LoginRequest>(_login);
    on<LogoutRequest>(_logout);
    on<PickImageRequest>(_pickImage);
    on<RegisterRequest>(_register);
    on<GetCurrentUserEvent>(_getCurrentUser);
    on<UpdateProfileRequest>(_updateProfile);
  }

  Future<void> _updateProfile(
    UpdateProfileRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final Result result = await UpdateProfileUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasource(
          httpsConsumer: HttpsConsumer(),
        ),
      ),
    ).call(event.fullName);
    if (result.isSuccess) {
      _initialUserInfo.name = event.fullName;
      emit(UpdateProfileSuccess());
      emit(GetCurrentUserSuccess(user: _initialUserInfo));
    } else {
      return emit(UpdateProfileFailure(failure: result.error));
    }
  }

  Future<void> _getCurrentUser(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(GetCurrentUserLoading());
    final Result result = await GetCurrentUserUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasource(
          httpsConsumer: HttpsConsumer(),
        ),
      ),
    ).call();
    if (result.isSuccess) {
      return emit(GetCurrentUserSuccess(user: result.data));
    } else {
      return emit(GetCurrentUserFailure(failure: result.error));
    }
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
    accessTokenPreferences!.clear();
    emit(LogoutSuccess());
  }
}
