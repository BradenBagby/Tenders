import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/route_controllers.dart';

class RoomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => RootRouteController.viewQRCode(context),
                child: Text("QR Code"),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () =>
                    BlocProvider.of<RoomAuthCubit>(context).leaveRoom(),
                child: Text("Leave"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
