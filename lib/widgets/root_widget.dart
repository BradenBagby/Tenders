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
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1800.0),
                    side: BorderSide(color: Colors.black, width: 0.2)),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.black),
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
                    return Colors.white;
                  return Colors.white;
                },
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: RootRouteController.key,
        initialRoute: RootRouteController.routeWelcome,
        onGenerateRoute: RootRouteController.generateRoute,
      ),
    );
  }
}
