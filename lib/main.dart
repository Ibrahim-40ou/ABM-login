import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/routing/routes.dart';
import 'core/sizing/size_config.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

SharedPreferences? arabicCheck;
SharedPreferences? darkModeCheck;
SharedPreferences? loginCheck;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  loginCheck = await SharedPreferences.getInstance();
  arabicCheck = await SharedPreferences.getInstance();
  darkModeCheck = await SharedPreferences.getInstance();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'DZ'),
      ],
      path: 'assets/translations',
      saveLocale: true,
      // startLocale: const Locale('ar', 'DZ'),
      startLocale: arabicCheck!.getBool('isArabic') == null ||
              arabicCheck!.getBool('isArabic') == false
          ? const Locale('en', 'US')
          : const Locale('ar', 'DZ'),
      fallbackLocale: const Locale('en', 'US'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return MaterialApp.router(
          title: 'ABM Login',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: appRouter.config(),
          theme: light,
          darkTheme: dark,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
