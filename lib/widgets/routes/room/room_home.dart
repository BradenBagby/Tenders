import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/widgets/routes/room/drawer/room_drawer.dart';

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
      child: BlocBuilder<RoomCubit, RoomState>(
        bloc: roomCubit,
        builder: (context, state) {
          return Scaffold(
            drawer: RoomDrawer(),
            appBar: AppBar(
              title: Text(
                state.members.length.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}
