import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/room_auth_cubit.dart';
import 'package:tenders/widgets/routes/welcome/welcome_page.dart';

class RootRouteController {
  const RootRouteController._();
  static final key = GlobalKey<NavigatorState>();

  static const routeWelcome = "welcome";
  static const routeRoom = "room";

  //. tells root route controller to start listening for room changes and updating our page uatomatically
  static Future<void> listen() async {
    final authCubit = GetIt.I<RoomAuthCubit>();
    RoomAuthState lastState = authCubit.state;
    authCubit.stream.listen((state) {
      // if we go from authenticated to unathenticated, or vise versa, listen to that
      if ((lastState.currentRoom == null && state.currentRoom != null) ||
          (lastState.currentRoom != null && state.currentRoom == null)) {
        _roomStateChanged(state);
      }
      lastState = state;
    });
    _roomStateChanged(authCubit.state);
  }

  /// internal function to react to auth state changes
  static void _roomStateChanged(RoomAuthState state) {
    if (key.currentContext == null) return;
    final nav = Navigator.of(key.currentContext!);
    if (state.currentRoom != null) {
      nav.pushNamedAndRemoveUntil(routeRoom, (_) => false);
    } else {
      nav.pushNamedAndRemoveUntil(routeWelcome, (_) => false);
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeWelcome:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case routeRoom:
        throw Exception("yeyeyeeeee");
      default:
        throw UnimplementedError();
    }
  }
}

class AuthRouteController {
  const AuthRouteController._();
  static final key = GlobalKey<NavigatorState>();
}
