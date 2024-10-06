// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:abm_login/core/routing/initial_route.dart' as _i4;
import 'package:abm_login/features/profile/presentation/pages/add_complaint.dart'
    as _i1;
import 'package:abm_login/features/profile/presentation/pages/app.dart' as _i2;
import 'package:abm_login/features/profile/presentation/pages/home.dart' as _i3;
import 'package:abm_login/features/profile/presentation/pages/profile_information.dart'
    as _i8;
import 'package:abm_login/features/profile/presentation/pages/settings.dart'
    as _i10;
import 'package:abm_login/features/auth/presentation/pages/landing.dart' as _i5;
import 'package:abm_login/features/auth/presentation/pages/login.dart' as _i6;
import 'package:abm_login/features/auth/presentation/pages/otp.dart' as _i7;
import 'package:abm_login/features/auth/presentation/pages/register.dart'
    as _i9;
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/cupertino.dart' as _i13;
import 'package:flutter/material.dart' as _i12;

/// generated route for
/// [_i1.AddComplaint]
class AddComplaint extends _i11.PageRouteInfo<void> {
  const AddComplaint({List<_i11.PageRouteInfo>? children})
      : super(
          AddComplaint.name,
          initialChildren: children,
        );

  static const String name = 'AddComplaint';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddComplaint();
    },
  );
}

/// generated route for
/// [_i2.App]
class App extends _i11.PageRouteInfo<AppArgs> {
  App({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          App.name,
          args: AppArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'App';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppArgs>(orElse: () => const AppArgs());
      return _i2.App(key: args.key);
    },
  );
}

class AppArgs {
  const AppArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'AppArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.Home]
class Home extends _i11.PageRouteInfo<void> {
  const Home({List<_i11.PageRouteInfo>? children})
      : super(
          Home.name,
          initialChildren: children,
        );

  static const String name = 'Home';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.Home();
    },
  );
}

/// generated route for
/// [_i4.InitialScreen]
class InitialRoute extends _i11.PageRouteInfo<void> {
  const InitialRoute({List<_i11.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.InitialScreen();
    },
  );
}

/// generated route for
/// [_i5.Landing]
class Landing extends _i11.PageRouteInfo<void> {
  const Landing({List<_i11.PageRouteInfo>? children})
      : super(
          Landing.name,
          initialChildren: children,
        );

  static const String name = 'Landing';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.Landing();
    },
  );
}

/// generated route for
/// [_i6.Login]
class Login extends _i11.PageRouteInfo<LoginArgs> {
  Login({
    _i13.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          Login.name,
          args: LoginArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Login';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginArgs>(orElse: () => const LoginArgs());
      return _i6.Login(key: args.key);
    },
  );
}

class LoginArgs {
  const LoginArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'LoginArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.OTP]
class OTP extends _i11.PageRouteInfo<OTPArgs> {
  OTP({
    _i13.Key? key,
    required String phoneNumber,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          OTP.name,
          args: OTPArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'OTP';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OTPArgs>();
      return _i7.OTP(
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

  final _i13.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'OTPArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i8.ProfileInformation]
class ProfileInformation extends _i11.PageRouteInfo<void> {
  const ProfileInformation({List<_i11.PageRouteInfo>? children})
      : super(
          ProfileInformation.name,
          initialChildren: children,
        );

  static const String name = 'ProfileInformation';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i8.ProfileInformation();
    },
  );
}

/// generated route for
/// [_i9.Register]
class Register extends _i11.PageRouteInfo<RegisterArgs> {
  Register({
    _i13.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          Register.name,
          args: RegisterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Register';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<RegisterArgs>(orElse: () => const RegisterArgs());
      return _i9.Register(key: args.key);
    },
  );
}

class RegisterArgs {
  const RegisterArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'RegisterArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.Settings]
class Settings extends _i11.PageRouteInfo<void> {
  const Settings({List<_i11.PageRouteInfo>? children})
      : super(
          Settings.name,
          initialChildren: children,
        );

  static const String name = 'Settings';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.Settings();
    },
  );
}
