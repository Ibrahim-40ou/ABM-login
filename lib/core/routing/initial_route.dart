import 'package:abm_login/core/routing/routes.gr.dart';
import 'package:abm_login/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:abm_login/main.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/widgets/loading_indicator.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        bool loggedIn = loginCheck!.getBool('loggedIn') == null ||
                loginCheck!.getBool('loggedIn') == false
            ? false
            : true;
        if (loggedIn) {
          context.router.replaceAll([App()]);
          context.read<AuthBloc>().add(GetCurrentUserEvent());
        } else {
          context.router.replaceAll([Landing()]);
        }
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: CustomLoadingIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
