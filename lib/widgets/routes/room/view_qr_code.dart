import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/dynamic_links.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';

class ViewQRCode extends StatelessWidget {
  final double size;
  const ViewQRCode({this.size = 200.0});
  @override
  Widget build(BuildContext context) {
    final currentRoom = BlocProvider.of<RoomAuthCubit>(context)
        .state
        .currentRoomCubit
        ?.state
        .room;
    return Center(
      child: currentRoom != null
          ? FutureBuilder<String>(
              future: DynamicLinks.createLink('room/${currentRoom.id}'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Loader();
                log("link: ${snapshot.data!}");
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      data: snapshot
                          .data!, // TODO: make this a dynamic link into the app so you can scan it and join without having the app
                      version: QrVersions.auto,
                      size: size,
                    ),
                  ],
                );
              })
          : Center(
              child: Text("Failed to get QR for current room"),
            ),
    );
  }
}
