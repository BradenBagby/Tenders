import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/widgets/routes/room/swipe/room_home.dart';
import 'package:tenders/widgets/routes/room/view_qr_code.dart';
import 'package:tenders/widgets/routes/welcome/welcome_page.dart';

class RootRouteController {
  const RootRouteController._();
  static final key = GlobalKey<NavigatorState>();

  static const routeWelcome = "welcome";
  static const routeRoom = "room";
  static const routeQRCode = "qr";

  //. tells root route controller to start listening for room changes and updating our page uatomatically
  static Future<void> listen() async {
    final authCubit = GetIt.I<RoomAuthCubit>();
    RoomAuthState lastState = authCubit.state;
    authCubit.stream.listen((state) {
      // if we go from authenticated to unathenticated, or vise versa, listen to that
      if ((lastState.currentRoomCubit == null &&
              state.currentRoomCubit != null) ||
          (lastState.currentRoomCubit != null &&
              state.currentRoomCubit == null)) {
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
    if (state.currentRoomCubit != null) {
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
        return MaterialPageRoute(builder: (_) => RoomHome());
      case routeQRCode:
        return MaterialPageRoute(
          builder: (_) => ViewQRCode(),
          fullscreenDialog: true,
        );
      default:
        throw UnimplementedError();
    }
  }

  static Future<void> viewQRCode(BuildContext context) =>
      Navigator.of(context).pushNamed(RootRouteController.routeQRCode);
}
