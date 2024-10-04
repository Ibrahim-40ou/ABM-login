import 'package:abm_login/core/sizing/size_config.dart';
import 'package:abm_login/core/utils/common_functions.dart';
import 'package:abm_login/features/auth/presentation/widgets/text.dart';
import 'package:abm_login/features/auth/presentation/widgets/text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.gr.dart';
import '../bloc/auth_bloc.dart';
import '../cubit/timer_cubit.dart';
import '../widgets/button.dart';

@RoutePage()
class Login extends StatelessWidget {
  final TextEditingController _phoneNumber = TextEditingController();
  final _key = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SendOTPFailure) {
          Common().showDialogue(
            context,
            state.failure!,
            '',
            () {},
            () {},
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomButton(
                      function: () {
                        context.router.popForced(true);
                      },
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                      width: 12.w,
                      height: 6.h,
                      child: Icon(
                        CupertinoIcons.back,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    CustomText(
                      text: 'step 1 of 2',
                      color: Theme.of(context).colorScheme.primary,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: 1.h),
                    CustomText(
                      text: 'enter your mobile number',
                      size:
                          Localizations.localeOf(context).toString() == 'en_US'
                              ? 11.sp
                              : 8.sp,
                      weight: FontWeight.bold,
                      lineHeight: 0.1.h,
                    ),
                    SizedBox(height: 1.h),
                    CustomText(
                      text:
                          "we'll send you a 6-digit verification code to your mobile number to confirm your account",
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      controller: _phoneNumber,
                      labelText: 'phone number'.tr(),
                      type: TextInputType.number,
                      validatorFunction: _validatePhoneNumber,
                      isLast: true,
                    ),
                    Spacer(),
                    CustomButton(
                      function: () {
                        if (_key.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                SendOTPRequest(
                                  phoneNumber: _phoneNumber.text.trim(),
                                ),
                              );
                          context.read<TimerCubit>().startTimer();
                          context.router.push(
                            OTP(
                              phoneNumber: _phoneNumber.text.trim(),
                            ),
                          );
                        }
                      },
                      height: 6.h,
                      color: Theme.of(context).colorScheme.primary,
                      child: CustomText(
                        text: 'send OTP',
                        color: Colors.white,
                      ),
                    ),
                  ],
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
