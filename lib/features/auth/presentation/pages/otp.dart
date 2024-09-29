import 'package:abm_login/core/routing/routes.gr.dart';
import 'package:abm_login/core/utils/common_functions.dart';
import 'package:abm_login/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:abm_login/features/auth/presentation/widgets/button.dart';
import 'package:abm_login/features/auth/presentation/widgets/loading_indicator.dart';
import 'package:abm_login/features/auth/presentation/widgets/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../cubit/timer_cubit.dart';

@RoutePage()
class OTP extends StatelessWidget {
  final String phoneNumber;
  final TextEditingController _otp = TextEditingController();
  final _key = GlobalKey<FormState>();

  OTP({super.key, required this.phoneNumber});

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
                    MyButton(
                      function: () {
                        context.router.popForced(true);
                      },
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                      width: 48,
                      height: 48,
                      child: Icon(
                        CupertinoIcons.back,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                    SizedBox(height: 20),
                    MyText(
                      text: 'enter the verification code',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                    Row(
                      children: <Widget>[
                        MyText(
                          text: 'code sent to ',
                          color: Theme.of(context).textTheme.labelMedium!.color,
                          overflow: TextOverflow.visible,
                        ),
                        MyText(
                          text: phoneNumber,
                          color: Theme.of(context).colorScheme.primary,
                          overflow: TextOverflow.visible,
                          weight: FontWeight.bold,
                        )
                      ],
                    ),
                    MyText(
                      text: 'enter the code below to log in',
                      color: Theme.of(context).textTheme.labelMedium!.color,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 40),
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
                                MyText(
                                  text: 'resend code in:',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                MyText(
                                  text: ' ${timerState.remainingTime}',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                MyText(
                                  text: 's',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            MyButton(
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
                              height: 50,
                              color: timerState.isButtonDisabled
                                  ? Colors.grey
                                  : Theme.of(context).colorScheme.primary,
                              child: MyText(
                                text: 'resend code',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    MyButton(
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
                      height: 50,
                      color: Theme.of(context).colorScheme.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (state is LoginLoading)
                            Row(
                              children: [
                                LoadingIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                          MyText(
                            text: 'login',
                            color: Colors.white,
                          ),
                        ],
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
