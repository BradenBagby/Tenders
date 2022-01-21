import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/dynamic_links.dart';
import 'package:tenders/widgets/routes/room/view_qr_code.dart';

class WaitingForFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = math.min(size.width, size.height);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    GetIt.I<RoomAuthCubit>().leaveRoom();
                  },
                ),
              ),
            ),
            Text(
              "Waiting for friends",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            ViewQRCode(
              size: width * 0.8,
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () async {
                // get short link and share
                final link = await DynamicLinks.createLink(
                    'room/${BlocProvider.of<RoomCubit>(context).state.room.id}',
                    preferShort: true);
                await FlutterShare.share(
                  title: 'Find Tendies!',
                  text: 'Swipe with me to match my appetite',
                  linkUrl: link,
                );
              },
              child: Column(
                children: [
                  Text(
                    "Or send an invite",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.ios_share_sharp,
                      size: 64,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
