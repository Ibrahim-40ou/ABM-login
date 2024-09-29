import 'package:abm_login/core/routing/routes.gr.dart';
import 'package:abm_login/core/sizing/size_config.dart';
import 'package:abm_login/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:abm_login/features/auth/presentation/cubit/timer_cubit.dart';
import 'package:abm_login/features/auth/presentation/widgets/button.dart';
import 'package:abm_login/features/auth/presentation/widgets/text.dart';
import 'package:abm_login/features/auth/presentation/widgets/text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';

@RoutePage()
class Login extends StatelessWidget {
  final TextEditingController _phoneNumber = TextEditingController();
  final _key = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: 100.w,
                height: 48.h,
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      MyText(
                        text: 'welcome to ABM',
                        weight: FontWeight.bold,
                        size: 24,
                      ),
                      MyText(
                        text:
                            'enter your mobile number to receive the verification code and log in',
                        color: Theme.of(context).textTheme.labelMedium!.color,
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: 16),
                      MyField(
                        controller: _phoneNumber,
                        labelText: 'phone number'.tr(),
                        validatorFunction: _validatePhoneNumber,
                        type: TextInputType.number,
                        isLast: true,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const MyText(
                            text: "don't have an account?",
                            weight: FontWeight.normal,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.router.push(Register());
                            },
                            child: MyText(
                              text: ' register',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(height: 13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          MyButton(
                            width: 30,
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
                                        MyButton(
                                          function: () {
                                            context.setLocale(
                                                const Locale('en', 'US'));
                                            arabicCheck!
                                                .setBool('isArabic', false);
                                            context.router.popForced();
                                          },
                                          color: Colors.transparent,
                                          child: MyText(
                                            text: 'english',
                                          ),
                                        ),
                                        MyButton(
                                          function: () {
                                            arabicCheck!
                                                .setBool('isArabic', true);
                                            context.setLocale(
                                                const Locale('ar', 'DZ'));
                                            context.router.popForced();
                                          },
                                          color: Colors.transparent,
                                          child: MyText(
                                            text: 'arabic',
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            color: Colors.transparent,
                            child: Icon(
                              Icons.language,
                              size: 24,
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                          ),
                          SizedBox(width: 8),
                          MyButton(
                            width: 30,
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
                                        MyButton(
                                          function: () {
                                            context.read<AuthBloc>().add(
                                                  ChangeTheme(
                                                    isDarkMode: true,
                                                  ),
                                                );
                                            context.router.popForced();
                                          },
                                          color: Colors.transparent,
                                          child: MyText(
                                            text: 'dark',
                                          ),
                                        ),
                                        MyButton(
                                          function: () {
                                            context.read<AuthBloc>().add(
                                                  ChangeTheme(
                                                    isDarkMode: false,
                                                  ),
                                                );
                                            context.router.popForced();
                                          },
                                          color: Colors.transparent,
                                          child: MyText(
                                            text: 'light',
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            color: Colors.transparent,
                            child: Icon(
                              Icons.dark_mode_outlined,
                              size: 24,
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13),
                      MyButton(
                        function: () {
                          if (_key.currentState!.validate()) {
                            context.read<AuthBloc>().add(SendOTPRequest(
                                phoneNumber: _phoneNumber.text.trim()));
                            context.read<TimerCubit>().startTimer();
                            context.router.push(
                                OTP(phoneNumber: _phoneNumber.text.trim()));
                          }
                        },
                        height: 50,
                        color: Theme.of(context).colorScheme.primary,
                        child: MyText(
                          text: 'continue',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String? _validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'please enter a phone number'.tr();
  }
  final RegExp phoneRegex = RegExp(r'^(077|078|079|075)\d{8}$');
  if (!phoneRegex.hasMatch(value)) {
    return 'enter a valid phone number'.tr();
  }
  return null;
}
