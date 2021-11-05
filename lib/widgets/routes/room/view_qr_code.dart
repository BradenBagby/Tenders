import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/route_controllers.dart';

class ViewQRCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentRoom = BlocProvider.of<RoomAuthCubit>(context)
        .state
        .currentRoomCubit
        ?.state
        .room;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: currentRoom != null
            ? QrImage(
                data: currentRoom
                    .id, // TODO: make this a dynamic link into the app so you can scan it and join without having the app
                version: QrVersions.auto,
                size: 200.0,
              )
            : Center(
                child: Text("Failed to get QR for current room"),
              ),
      ),
    );
  }
}
