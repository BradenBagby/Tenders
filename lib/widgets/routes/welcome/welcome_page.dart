import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => true
                    ? null
                    : BlocProvider.of<RoomAuthCubit>(context).createRoom(
                        settings: RoomSettings(
                            radius: 777,
                            type: PlaceType.FOOD,
                            openNow: false)), // TODO: if fail show message
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Go",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
