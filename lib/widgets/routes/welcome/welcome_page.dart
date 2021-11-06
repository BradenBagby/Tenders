import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => BlocProvider.of<RoomAuthCubit>(context)
                  .createRoom(
                      settings: RoomSettings(
                          radius: 777,
                          type: PlaceType.FOOD,
                          openNow: false)), // TODO: if fail show message
              child: Text("Go"),
            ),
          ],
        ),
      ),
    );
  }
}
