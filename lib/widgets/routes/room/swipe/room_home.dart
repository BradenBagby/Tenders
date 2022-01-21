import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/widgets/common/displays/restauraunt_display.dart';
import 'package:tenders/widgets/common/web_controls.dart';
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
      child: WebPageControls(
        onTap: (accepted) => _next(accepted, roomCubit),
        child: Scaffold(
            drawer: RoomDrawer(),
            body: BlocBuilder<RoomCubit, RoomState>(
              bloc: roomCubit,
              builder: (context, state) {
                if (state.outOfRestauraunts) {
                  return Center(
                    child:
                        Text("No restaurants nearby. Try a different location"),
                  );
                }
                if (state.showNeedsLocation)
                  return Center(
                    child: Text("Enable location in settings to continue"),
                  );
                if (state.currentViewRestauraunt == null) {
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Looking for nearby restaurants")
                    ],
                  ));
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
                      onAccept: () =>
                          _next(true, BlocProvider.of<RoomCubit>(context)),
                      onReject: () =>
                          _next(false, BlocProvider.of<RoomCubit>(context)),
                      child: RestaurauntDisplay(state.currentViewRestauraunt!),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }

  void _next(bool accepted, RoomCubit cubit) {
    cubit.next(accepted: accepted);
  }
}
