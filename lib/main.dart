import 'package:abm_login/core/theme/colors.dart';
import 'package:abm_login/core/routing/navigation_cubit.dart';
import 'package:abm_login/core/theme/theme_state/theme_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/routing/routes.dart';
import 'core/sizing/size_config.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/cubit/timer_cubit.dart';

SharedPreferences? arabicCheck;
SharedPreferences? darkModeCheck;
SharedPreferences? loginCheck;
SharedPreferences? accessTokenPreferences;
bool? isDarkMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  loginCheck = await SharedPreferences.getInstance();
  arabicCheck = await SharedPreferences.getInstance();
  darkModeCheck = await SharedPreferences.getInstance();
  accessTokenPreferences = await SharedPreferences.getInstance();
  isDarkMode = darkModeCheck?.getBool('isDarkMode') ?? false;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'DZ'),
      ],
      path: 'assets/translations',
      saveLocale: true,
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
          BlocProvider<TimerCubit>(
            create: (context) => TimerCubit(),
          ),
          BlocProvider<NavigationCubit>(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(
            create: (context) => ThemeBloc()
              ..add(
                LoadTheme(
                  isDarkMode: isDarkMode!,
                ),
              ),
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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isDarkMode = state is ThemeChanged
                ? state.isDarkMode
                : darkModeCheck?.getBool('isDarkMode') ?? false;
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                systemNavigationBarColor: isDarkMode
                    ? MyColors.backgroundDark
                    : MyColors.backgroundLight,
                systemNavigationBarIconBrightness:
                    isDarkMode ? Brightness.light : Brightness.dark,
                statusBarColor: isDarkMode
                    ? MyColors.backgroundDark
                    : MyColors.backgroundLight,
                statusBarBrightness:
                    isDarkMode ? Brightness.dark : Brightness.light,
                statusBarIconBrightness:
                    isDarkMode ? Brightness.light : Brightness.dark,
              ),
            );
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
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
      },
    );
  }
}
