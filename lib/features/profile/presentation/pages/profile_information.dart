import 'package:abm_login/core/sizing/size_config.dart';
import 'package:abm_login/features/auth/domain/entities/user_entity.dart';
import 'package:abm_login/features/auth/presentation/widgets/button.dart';
import 'package:abm_login/features/auth/presentation/widgets/text.dart';
import 'package:abm_login/features/auth/presentation/widgets/text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/widgets/loading_indicator.dart';

@RoutePage()
class ProfileInformation extends StatelessWidget {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _governorate = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  late UserEntity _initialUserInfo = UserEntity(
    name: '',
    phoneNumber: '',
    governorate: '',
    profilePicture: '',
  );

  ProfileInformation({super.key});

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
        if (state is GetCurrentUserSuccess) {
          _initialUserInfo = state.user;
          _fullName.text = _initialUserInfo.name;
          // _governorate.text = _initialUserInfo.governorate;
          // _phoneNumber.text = _initialUserInfo.phoneNumber;
        }
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: CustomButton(
                function: () {
                  context.router.popForced(true);
                },
                height: 48,
                width: 48,
                color: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Iconsax.arrow_left_2,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 18.h),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 72.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 2.h),
                            CustomField(
                              controller: _fullName,
                              labelText: 'full name'.tr(),
                              // onChanged: ,
                            ),
                            SizedBox(height: 1.h),
                            CustomField(
                              controller: _governorate,
                              labelText: 'governorate'.tr(),
                              enabled: false,
                            ),
                            SizedBox(height: 1.h),
                            CustomField(
                              controller: _phoneNumber,
                              labelText: 'phone number'.tr(),
                              enabled: false,
                              isLast: true,
                              type: TextInputType.number,
                            ),
                            SizedBox(height: 4.h),
                            CustomButton(
                              function: () {
                                bool proceed =
                                    _fullName.text == _initialUserInfo.name &&
                                        _phoneNumber.text ==
                                            _initialUserInfo.phoneNumber &&
                                        _governorate.text ==
                                            _initialUserInfo.governorate;
                                if (!proceed) {
                                  context.read<AuthBloc>().add(
                                        UpdateProfileRequest(
                                          fullName: _fullName.text,
                                        ),
                                      );
                                }
                              },
                              disabled:
                                  state is UpdateProfileLoading ? true : false,
                              height: 6.h,
                              color: Theme.of(context).colorScheme.primary,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (state is UpdateProfileLoading)
                                    Row(
                                      children: [
                                        CustomLoadingIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        SizedBox(width: 8),
                                      ],
                                    ),
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.save_2,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      CustomText(
                                        text: 'save',
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -6.5.h,
                        child: SizedBox(
                          width: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                              SizedBox(height: 1.h),
                              CustomText(
                                text: 'edit profile information',
                                size: 8.sp,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
