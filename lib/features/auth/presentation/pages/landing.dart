import 'package:abm_login/core/routing/routes.gr.dart';
import 'package:abm_login/core/sizing/size_config.dart';
import 'package:abm_login/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:abm_login/features/auth/presentation/widgets/button.dart';
import 'package:abm_login/features/auth/presentation/widgets/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../main.dart';

@RoutePage()
class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/account.svg',
                      height: 25.h,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(20),
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
                    height: 40.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'welcome to ABM',
                              weight: FontWeight.bold,
                              size: Localizations.localeOf(context).toString() == 'en_US' ? 7.5.sp : 7.sp,
                            ),
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
                                              context.read<AuthBloc>().add(
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
                                              context.read<AuthBloc>().add(
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
                              width: 6.w,
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.light_mode,
                                    size: 24,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CustomText(
                          text:
                              'either login or register to continue and use the app',
                          color: Theme.of(context).textTheme.labelMedium!.color,
                          overflow: TextOverflow.visible,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                          width: 25.w,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.language,
                                size: 24,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                              ),
                              SizedBox(width: 1.5.w),
                              CustomText(text: 'language')
                            ],
                          ),
                        ),
                        Spacer(),
                        CustomButton(
                          function: () {
                            context.router.push(Login());
                          },
                          height: 6.h,
                          color: Theme.of(context).colorScheme.primary,
                          child: CustomText(
                            text: 'login',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        CustomButton(
                          function: () {
                            context.router.push(Register());
                          },
                          height: 6.h,
                          color: Theme.of(context).colorScheme.primary,
                          child: CustomText(
                            text: 'register',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
