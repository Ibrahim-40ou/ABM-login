import 'package:abm_login/core/routing/routes.gr.dart';
import 'package:abm_login/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:abm_login/features/auth/presentation/widgets/button.dart';
import 'package:abm_login/features/auth/presentation/widgets/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.router.replaceAll([InitialRoute()]);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyText(text: 'welcome to ABM'),
                    SizedBox(height: 20),
                    MyButton(
                      function: () {
                        context.read<AuthBloc>().add(LogoutRequest());
                      },
                      color: Theme.of(context).colorScheme.primary,
                      child: MyText(
                        text: 'logout',
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
