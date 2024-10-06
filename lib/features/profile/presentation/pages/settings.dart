import 'package:abm_login/core/sizing/size_config.dart';
import 'package:abm_login/core/theme/theme_state/theme_bloc.dart';
import 'package:abm_login/features/auth/presentation/widgets/button.dart';
import 'package:abm_login/features/auth/presentation/widgets/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/routing/routes.gr.dart';
import '../../../../main.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

@RoutePage()
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.primary,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 100.h,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomButton(
                            function: () {
                              context.router.push(ProfileInformation());
                            },
                            height: 6.h,
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(
                                      Iconsax.user,
                                      size: 24,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color,
                                    ),
                                    SizedBox(width: 8),
                                    CustomText(
                                      text: 'profile information',
                                      color: isDarkMode
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Localizations.localeOf(context)
                                                  .toString() ==
                                              'en_US'
                                          ? Iconsax.arrow_right_3
                                          : Iconsax.arrow_left_2,
                                      size: 24,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color,
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 1.h),
                          CustomButton(
                            function: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.2)
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    width: 100.w,
                                    height: 18.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CustomButton(
                                          function: () {
                                            context.setLocale(
                                                const Locale('en', 'US'));
                                            arabicCheck!
                                                .setBool('isArabic', false);
                                            context.router.popForced();
                                          },
                                          color: Colors.transparent,
                                          child: CustomText(
                                            text: 'english',
                                          ),
                                        ),
                                        CustomButton(
                                          function: () {
                                            arabicCheck!
                                                .setBool('isArabic', true);
                                            context.setLocale(
                                                const Locale('ar', 'DZ'));
                                            context.router.popForced();
                                          },
                                          color: Colors.transparent,
                                          child: CustomText(
                                            text: 'arabic',
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            height: 6.h,
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(
                                      Iconsax.language_square,
                                      size: 24,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color,
                                    ),
                                    SizedBox(width: 8),
                                    CustomText(
                                      text: 'language',
                                      color: isDarkMode
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 1.h),
                          CustomButton(
                            function: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.2)
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    width: 100.w,
                                    height: 18.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CustomButton(
                                          function: () {
                                            context.read<ThemeBloc>().add(
                                                  ChangeTheme(
                                                    isDarkMode: true,
                                                  ),
                                                );
                                            context.router.popForced();
                                          },
                                          color: Colors.transparent,
                                          child: CustomText(
                                            text: 'dark',
                                          ),
                                        ),
                                        CustomButton(
                                          function: () {
                                            context.read<ThemeBloc>().add(
                                                  ChangeTheme(
                                                    isDarkMode: false,
                                                  ),
                                                );
                                            context.router.popForced();
                                          },
                                          color: Colors.transparent,
                                          child: CustomText(
                                            text: 'light',
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            height: 6.h,
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(
                                      Iconsax.sun_1,
                                      size: 24,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color,
                                    ),
                                    SizedBox(width: 8),
                                    CustomText(
                                      text: 'theme',
                                      color: isDarkMode
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 1.h),
                          BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is LogoutSuccess) {
                                context.router.replaceAll([InitialRoute()]);
                              }
                            },
                            child: CustomButton(
                              function: () {
                                context.read<AuthBloc>().add(LogoutRequest());
                              },
                              height: 6.h,
                              color: isDarkMode
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 20),
                                      Icon(
                                        Iconsax.logout,
                                        size: 24,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color,
                                      ),
                                      SizedBox(width: 8),
                                      CustomText(
                                        text: 'logout',
                                        color: isDarkMode
                                            ? Colors.white
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16.5.h,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: isDarkMode
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.secondary,
                        child: Center(
                          child: Icon(
                            Iconsax.user,
                            size: 26,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if(state is GetCurrentUserSuccess)
                      CustomText(
                        text: state.user.name,
                        size: 10.sp,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
