import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: GetIt.I<RoomAuthCubit>(),
        )
      ],
      child: MaterialApp(
        title: "Expense App",
        theme: _theme(Brightness.light),
        darkTheme: _theme(Brightness.dark),
        debugShowCheckedModeBanner: false,
        navigatorKey: RootRouteController.key,
        initialRoute: RootRouteController.routeWelcome,
        onGenerateRoute: RootRouteController.generateRoute,
      ),
    );
  }
}

ThemeData _theme(Brightness brightness) {
  final start = ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor:
        brightness == Brightness.light ? null : Color(0xff121212),
    sliderTheme: SliderThemeData(
      thumbColor: primaryColor,
      activeTrackColor: primaryColor,
      inactiveTrackColor: secondaryColor.withAlpha(50),
      overlayColor: secondaryColor.withAlpha(50),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
    ),
    unselectedWidgetColor: secondaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1800.0),
              side: BorderSide(
                  color: brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  width: 0.2)),
        ),
        foregroundColor: brightness == Brightness.light
            ? MaterialStateProperty.all(Colors.black)
            : MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) return 4;
            return 0;
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed))
              return brightness == Brightness.light
                  ? Colors.white
                  : Colors.black.withAlpha(50);
            return brightness == Brightness.light
                ? Colors.white
                : Colors.transparent;
          },
        ),
      ),
    ),
  );

  return start.copyWith(
      colorScheme: start.colorScheme.copyWith(
    surface: brightness == Brightness.light ? null : Color(0xff121212),
  ));
}

final primaryColor = Color(0xffFF512F);
final secondaryColor = Color(0xffF09819);
