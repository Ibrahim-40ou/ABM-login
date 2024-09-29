import 'package:abm_login/core/routing/routes.gr.dart';
import 'package:abm_login/main.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
        } else {
          context.router.replaceAll([Login()]);
        }
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: LoadingIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
