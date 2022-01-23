import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/widgets/routes/match/match_page.dart';
import 'package:tenders/widgets/routes/room/swipe/room_home.dart';
import 'package:tenders/widgets/routes/room/view_qr_code.dart';
import 'package:tenders/widgets/routes/welcome/welcome_page.dart';

class RootRouteController {
  const RootRouteController._();
  static final key = GlobalKey<NavigatorState>();

  static const routeWelcome = "welcome";
  static const routeRoom = "room";
  static const routeQRCode = "qr";
  static const routeMatch = "match";

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
      case routeMatch:
        final args = settings.arguments as Map<String, dynamic>;
        final restaurant = args["restaurant"] as Restauraunt;
        final perfectMatch = args["perfectMatch"] as bool;
        return MaterialPageRoute(
            builder: (context) => MatchPage(
                  restaurant,
                  totalMatch: perfectMatch,
                ),
            fullscreenDialog: true);
      default:
        throw UnimplementedError();
    }
  }

  static Future<void> viewQRCode(BuildContext context) =>
      Navigator.of(context).pushNamed(RootRouteController.routeQRCode);

  static Future<void> showMatch(BuildContext context,
          {required Restauraunt restauraunt, bool perfectMatch = true}) =>
      Navigator.of(context).pushNamed(RootRouteController.routeMatch,
          arguments: {"restaurant": restauraunt, "perfectMatch": perfectMatch});
}

class FadePageRoute<T> extends PageRoute<T> {
  final Duration duration;
  final bool isOpaque;
  FadePageRoute(this.child,
      {this.duration = const Duration(milliseconds: 300),
      this.isOpaque = true});

  @override
  Color? get barrierColor => null;

  final Widget child;

  @override
  bool get opaque => isOpaque;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => false;

  @override
  Duration get transitionDuration => duration;

  @override
  String? get barrierLabel => null;
}
