import 'package:abm_login/core/sizing/size_config.dart';
import 'package:abm_login/features/auth/presentation/widgets/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/routing/routes.gr.dart';
import '../../../../core/utils/common_functions.dart';
import '../bloc/auth_bloc.dart';
import '../cubit/timer_cubit.dart';
import '../widgets/button.dart';

@RoutePage()
class OTP extends StatelessWidget {
  final String phoneNumber;
  final _key = GlobalKey<FormState>();
  final TextEditingController _otp = TextEditingController();

  OTP({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.router.replaceAll([InitialRoute()]);
        }
        if (state is LoginFailure) {
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
                      text: 'step 2 of 2',
                      color: Theme.of(context).colorScheme.primary,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: 1.h),
                    CustomText(
                      text: 'enter 6-digit verification code',
                      size:
                          Localizations.localeOf(context).toString() == 'en_US'
                              ? 12.sp
                              : 9.sp,
                      weight: FontWeight.bold,
                      lineHeight: 0.1.h,
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "enter the code sent to",
                        ),
                        CustomText(
                          text: ' $phoneNumber',
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    PinCodeTextField(
                      errorTextSpace: 30,
                      appContext: context,
                      length: 6,
                      controller: _otp,
                      keyboardType: TextInputType.number,
                      cursorColor: Theme.of(context).colorScheme.primary,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        inactiveColor:
                            Theme.of(context).textTheme.bodyMedium!.color,
                        activeColor: Theme.of(context).colorScheme.primary,
                        selectedColor: Theme.of(context).colorScheme.primary,
                      ),
                      validator: _validateOTP,
                    ),
                    Spacer(),
                    BlocBuilder<TimerCubit, TimerState>(
                      builder: (context, timerState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: 'resend code in:',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                CustomText(
                                  text: ' ${timerState.remainingTime}',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                CustomText(
                                  text: 's',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                            CustomButton(
                              disabled: timerState.isButtonDisabled,
                              function: timerState.isButtonDisabled
                                  ? () {}
                                  : () {
                                      context.read<TimerCubit>().resetTimer();
                                      context.read<AuthBloc>().add(
                                            SendOTPRequest(
                                              phoneNumber: phoneNumber.trim(),
                                            ),
                                          );
                                    },
                              height: 6.h,
                              color: timerState.isButtonDisabled
                                  ? Colors.grey
                                  : Theme.of(context).colorScheme.primary,
                              child: CustomText(
                                text: 'resend code',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 1.h),
                    CustomButton(
                      function: () {
                        if (_key.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                LoginRequest(
                                  phoneNumber: phoneNumber,
                                  otp: _otp.text.trim(),
                                ),
                              );
                        }
                      },
                      height: 6.h,
                      color: Theme.of(context).colorScheme.primary,
                      child: CustomText(
                        text: 'login',
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

String? _validateOTP(String? value) {
  if (value == null || value.isEmpty) return 'enter the OTP'.tr();
  if (value.length < 6) return 'OTP must be 6 digits'.tr();
  return null;
}
