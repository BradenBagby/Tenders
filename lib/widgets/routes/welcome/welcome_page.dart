import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double radiusMiles = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _goButton(context),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text("Distance (miles):"),
                  ),
                  Slider(
                    value: radiusMiles,
                    onChanged: (val) {
                      setState(() {
                        radiusMiles = val;
                      });
                    },
                    min: 1,
                    max: 30,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _goButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => false
          ? null
          : BlocProvider.of<RoomAuthCubit>(context).createRoom(
              settings: RoomSettings(
                  radius: 777777,
                  type: PlaceType.RESTAURAT,
                  openNow: false)), // TODO: if fail show message
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Go",
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 40),
        ),
      ),
    );
  }
}
