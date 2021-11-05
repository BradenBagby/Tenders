import 'package:flutter/material.dart';
import 'package:tenders/widgets/routes/welcome/welcome_page.dart';

class RootRouteController {
  const RootRouteController._();
  static final key = GlobalKey<NavigatorState>();

  static const routeWelcome = "welcome";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeWelcome:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      default:
        throw UnimplementedError();
    }
  }
}

class AuthRouteController {
  const AuthRouteController._();
  static final key = GlobalKey<NavigatorState>();
}
