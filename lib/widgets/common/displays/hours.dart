import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';

class Hours extends StatelessWidget {
  final Restauraunt restauraunt;
  const Hours(this.restauraunt);
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().weekday;
    final roomCubit = GetIt.I<RoomAuthCubit>().state.currentRoomCubit;
    final currentLocation = roomCubit?.state.currentLocation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hours",
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          restauraunt.opennow ? "Open Now" : "Closed",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 4,
        ),
        ...restauraunt.hoursText.map((e) => Text(
              e,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: restauraunt.hoursText.indexOf(e) == today
                      ? FontWeight.bold
                      : FontWeight.normal),
            ))
      ],
    );
  }
}
