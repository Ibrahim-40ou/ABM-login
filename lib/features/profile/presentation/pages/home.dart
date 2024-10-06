import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.gr.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

@RoutePage()
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.surface,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.router.replaceAll([InitialRoute()]);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
}
