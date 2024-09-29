// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:abm_login/core/routing/initial_route.dart' as _i2;
import 'package:abm_login/features/auth/presentation/pages/app.dart' as _i1;
import 'package:abm_login/features/auth/presentation/pages/login.dart' as _i3;
import 'package:abm_login/features/auth/presentation/pages/otp.dart' as _i4;
import 'package:abm_login/features/auth/presentation/pages/register.dart'
    as _i5;
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart' as _i7;

/// generated route for
/// [_i1.App]
class App extends _i6.PageRouteInfo<void> {
  const App({List<_i6.PageRouteInfo>? children})
      : super(
          App.name,
          initialChildren: children,
        );

  static const String name = 'App';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.App();
    },
  );
}

/// generated route for
/// [_i2.InitialScreen]
class InitialRoute extends _i6.PageRouteInfo<void> {
  const InitialRoute({List<_i6.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.InitialScreen();
    },
  );
}

/// generated route for
/// [_i3.Login]
class Login extends _i6.PageRouteInfo<LoginArgs> {
  Login({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          Login.name,
          args: LoginArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Login';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginArgs>(orElse: () => const LoginArgs());
      return _i3.Login(key: args.key);
    },
  );
}

class LoginArgs {
  const LoginArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'LoginArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.OTP]
class OTP extends _i6.PageRouteInfo<OTPArgs> {
  OTP({
    _i8.Key? key,
    required String phoneNumber,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          OTP.name,
          args: OTPArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'OTP';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OTPArgs>();
      return _i4.OTP(
        key: args.key,
        phoneNumber: args.phoneNumber,
      );
    },
  );
}

class OTPArgs {
  const OTPArgs({
    this.key,
    required this.phoneNumber,
  });

  final _i8.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'OTPArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i5.Register]
class Register extends _i6.PageRouteInfo<void> {
  const Register({List<_i6.PageRouteInfo>? children})
      : super(
          Register.name,
          initialChildren: children,
        );

  static const String name = 'Register';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return _i5.Register();
    },
  );
}
