import 'package:tenders/application/cubit/room_cubit.dart';
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
          value: GetIt.I<RoomCubit>(),
        )
      ],
      child: MaterialApp(
        title: "Expense App",
        debugShowCheckedModeBanner: false,
        navigatorKey: RootRouteController.key,
        initialRoute: RootRouteController.routeWelcome,
        onGenerateRoute: RootRouteController.generateRoute,
      ),
    );
  }
}
