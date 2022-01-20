import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/widgets/common/displays/restauraunt_display.dart';
import 'package:tenders/widgets/routes/room/drawer/room_drawer.dart';
import 'package:tenders/widgets/routes/room/swipe/draggable_card.dart';

class RoomHome extends StatefulWidget {
  @override
  _RoomHomeState createState() => _RoomHomeState();
}

class _RoomHomeState extends State<RoomHome> {
  @override
  Widget build(BuildContext context) {
    final roomCubit =
        BlocProvider.of<RoomAuthCubit>(context).state.currentRoomCubit!;
    return BlocProvider.value(
      value: roomCubit,
      child: Scaffold(
          drawer: RoomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.onSurface),
          ),
          body: BlocBuilder<RoomCubit, RoomState>(
            bloc: roomCubit,
            builder: (context, state) {
              if (state.currentViewRestauraunt == null) {
                return CircularProgressIndicator();
              }

              final next =
                  state.currentViewIndex + 1 < state.restauraunts.length
                      ? state.restauraunts[state.currentViewIndex + 1]
                      : null;

              return Stack(
                children: [
                  if (next != null) RestaurauntDisplay(next),
                  DraggableCard(
                    key: ValueKey(state.currentViewRestauraunt!.id),
                    acceptOverlay: Container(
                      color: Colors.black,
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                    ),
                    denyOverlay: Container(
                      color: Colors.black,
                      child: Center(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                    onAccept: () {
                      BlocProvider.of<RoomCubit>(context).next(accepted: true);
                    },
                    onReject: () {
                      BlocProvider.of<RoomCubit>(context).next(accepted: false);
                    },
                    child: RestaurauntDisplay(state.currentViewRestauraunt!),
                  ),
                ],
              );
            },
          )),
    );
  }
}
