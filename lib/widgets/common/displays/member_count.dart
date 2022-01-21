import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/core/utility/dynamic_links.dart';

class MemberCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
      return InkWell(
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
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ...state.members
                  .map((e) => Icon(
                        Icons.person,
                        color: Theme.of(context)
                            .iconTheme
                            .color!
                            .withAlpha(e.disconnected ? 100 : 255),
                      ))
                  .toList(),
              Icon(
                Icons.ios_share_sharp,
              ),
            ],
          ));
    });
  }
}
