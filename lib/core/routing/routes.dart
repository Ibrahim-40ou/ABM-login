import 'package:abm_login/core/routing/routes.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: InitialRoute.page, initial: true),
        AutoRoute(page: App.page),
        AutoRoute(page: Login.page),
        AutoRoute(page: OTP.page),
        AutoRoute(page: Register.page),
      ];
}
