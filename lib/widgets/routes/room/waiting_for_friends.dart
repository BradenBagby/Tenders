import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/dynamic_links.dart';
import 'package:tenders/core/utility/share.dart';
import 'package:tenders/widgets/common/displays/member_count.dart';
import 'package:tenders/widgets/routes/room/view_qr_code.dart';

class WaitingForFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = math.min(size.width, size.height);
    TextStyle buttonText = Theme.of(context).textTheme.headline3!;
    if (size.height < 700) {
      buttonText = buttonText.copyWith(fontSize: buttonText.fontSize! * 0.7);
    }
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
              size: size.height < 700 ? (width * 0.6) : (width * 0.8),
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
                await Share.shareInvite(
                    link: link,
                    message: 'Swipe with me to decide where to eat!');
              },
              child: ElevatedButton(
                onPressed: () async {
                  // get short link and share
                  final link = await DynamicLinks.createLink(
                      'room/${BlocProvider.of<RoomCubit>(context).state.room.id}',
                      preferShort: true);
                  await Share.shareInvite(
                      link: link,
                      message: 'Swipe with me to decide where to eat!');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Invite",
                      style: buttonText,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.ios_share_sharp,
                      size: size.height < 700 ? 30 : 40,
                      color: Theme.of(context).textTheme.headline3!.color,
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            MemberCount(
              showInviteButton: false,
              size: 40,
            ),
            BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
              if (state.members.length <= 1 && !kDebugMode) {
                return SizedBox();
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: ElevatedButton(
                        child: Text(
                          "Start Swiping",
                          style: buttonText,
                        ),
                        onPressed: () {
                          BlocProvider.of<RoomCubit>(context).startSwiping();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    if (state.room.settings.locationString != null)
                      Text(
                        "${state.room.settings.query} in ${state.room.settings.locationString}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Even after clicking start, friends can still join! Find the QR code at any time by tapping the menu icon in the top left",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.caption!.fontSize! *
                                  (size.height < 700 ? 0.7 : 1)),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
