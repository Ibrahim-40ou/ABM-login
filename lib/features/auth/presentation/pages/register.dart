import 'dart:io';

import 'package:abm_login/core/routing/routes.gr.dart';
import 'package:abm_login/core/sizing/size_config.dart';
import 'package:abm_login/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:abm_login/features/auth/presentation/widgets/text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/common_functions.dart';
import '../cubit/timer_cubit.dart';
import '../widgets/button.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/text.dart';

@RoutePage()
class Register extends StatelessWidget {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _governorate = TextEditingController();
  final _key = GlobalKey<FormState>();
  File? _selectedImage;

  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.router.push(
            OTP(
              phoneNumber: _phoneNumber.text.trim(),
            ),
          );
        }
        if (state is RegisterFailure) {
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
        if (state is PickImageSuccess) {
          if (state.selectedImage != null) {
            _selectedImage = File(state.selectedImage!.path);
          }
        }
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _key,
                child: SingleChildScrollView(
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
                        text: 'register',
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                      MyText(text: 'create a new account'),
                      SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final XFile? selectedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            context.read<AuthBloc>().add(
                                  PickImageRequest(
                                    selectedImage: selectedImage,
                                  ),
                                );
                          },
                          child: Container(
                            height: 15.h,
                            width: 15.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.2),
                            ),
                            child: _selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    CupertinoIcons.person,
                                    size: 24,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      MyField(
                        controller: _fullName,
                        labelText: 'full name'.tr(),
                      ),
                      SizedBox(height: 20),
                      MyField(
                        controller: _phoneNumber,
                        labelText: 'phone number'.tr(),
                        type: TextInputType.number,
                        validatorFunction: _validateField,
                      ),
                      SizedBox(height: 20),
                      MyField(
                        controller: _governorate,
                        labelText: 'governorate'.tr(),
                        isLast: true,
                      ),
                      SizedBox(height: 40),
                      MyButton(
                        function: () {
                          if (_key.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  RegisterRequest(
                                    fullName: _fullName.text.trim(),
                                    phoneNumber: _phoneNumber.text.trim(),
                                  ),
                                );
                            if (state is RegisterSuccess) {
                              context.read<TimerCubit>().startTimer();
                            }
                          }
                        },
                        height: 50,
                        color: Theme.of(context).colorScheme.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (state is RegisterLoading)
                              Row(
                                children: [
                                  LoadingIndicator(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                            MyText(
                              text: 'register',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const MyText(
                            text: "already have an account?",
                            weight: FontWeight.normal,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.router.popForced();
                            },
                            child: MyText(
                              text: ' login',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
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

String? _validateField(String? value) =>
    value == null || value.isEmpty ? 'this field is required'.tr() : null;
