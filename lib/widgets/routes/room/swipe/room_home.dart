import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';
import 'package:tenders/widgets/common/displays/restauraunt_display.dart';
import 'package:tenders/widgets/common/web_controls.dart';
import 'package:tenders/widgets/routes/room/drawer/room_drawer.dart';
import 'package:tenders/widgets/routes/room/swipe/controls.dart';
import 'package:tenders/widgets/routes/room/swipe/draggable_card.dart';
import 'package:tenders/widgets/routes/room/waiting_for_friends.dart';

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
          body: _body(context, roomCubit),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, RoomCubit roomCubit) {
    return BlocBuilder<RoomCubit, RoomState>(
      bloc: roomCubit,
      builder: (context, state) {
        if (state.members.length == 1 && !kDebugMode) {
          return WaitingForFriends();
        }

        if (state.outOfRestauraunts) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SafeArea(
                  child: IconButton(
                      color: Theme.of(context).colorScheme.onBackground,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Center(
                child: Text("No restaurants nearby"),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          );
        }
        if (state.showNeedsLocation)
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Enable location in settings to continue"),
                ElevatedButton(
                  onPressed: () {
                    GetIt.I<RoomAuthCubit>().leaveRoom();
                  },
                  child: Text("Leave"),
                )
              ],
            ),
          );
        if (state.currentViewRestauraunt == null) {
          return Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Loader(),
              SizedBox(
                height: 8,
              ),
              Text("Looking for nearby restaurants")
            ],
          ));
        }

        final next = state.currentViewIndex + 1 < state.restauraunts.length
            ? state.restauraunts[state.currentViewIndex + 1]
            : null;

        return Stack(
          children: [
            if (next != null) RestaurauntDisplay(next),
            DraggableCard(
              key: ValueKey(state.currentViewRestauraunt!.id),
              acceptOverlay: Container(
                color: Color(0xff000f04),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
              ),
              denyOverlay: Container(
                color: Color(0xff0f0000),
                child: Center(
                  child: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ),
              onAccept: () => _next(true, BlocProvider.of<RoomCubit>(context)),
              onReject: () => _next(false, BlocProvider.of<RoomCubit>(context)),
              child: RestaurauntDisplay(state.currentViewRestauraunt!),
            ),
          ],
        );
      },
    );
  }

  void _next(bool accepted, RoomCubit cubit) {
    cubit.next(accepted: accepted);
  }
}
