import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';

class Navigation extends StatelessWidget {
  final Restauraunt restauraunt;
  const Navigation(this.restauraunt);
  @override
  Widget build(BuildContext context) {
    final roomCubit = GetIt.I<RoomAuthCubit>().state.currentRoomCubit;
    final currentLocation = roomCubit?.state.currentLocation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Navigation",
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          restauraunt.address,
          style: Theme.of(context).textTheme.caption,
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                MapsLauncher.launchQuery(restauraunt.address);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.drive_eta),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Directions",
                    style: Theme.of(context).textTheme.button,
                  ),
                  if (currentLocation != null)
                    Text(
                      " ${calculateDistance(restauraunt.latitude, restauraunt.longitude, currentLocation.latitude!, currentLocation.longitude!).toStringAsFixed(2)} miles",
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(fontWeight: FontWeight.w300),
                    )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
