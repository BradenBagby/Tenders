import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/core/utility/dynamic_links.dart';
import 'package:tenders/core/utility/share.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';

class MemberCount extends StatelessWidget {
  final bool showInviteButton;
  final double? size;
  const MemberCount({this.showInviteButton = true, this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
      return InkWell(
          onTap: () async {
            // get short link and share
            final link = await DynamicLinks.createLink(
                'room/${BlocProvider.of<RoomCubit>(context).state.room.id}',
                preferShort: true);
            await Share.shareInvite(
                link: link, message: 'Swipe with me to match my appetite');
          },
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ...state.members
                  .map((e) => Opacity(
                        opacity: e.disconnected ? 0.35 : 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: state.members.length > 1 ? 8.0 : 0),
                          child: Column(
                            children: [
                              Avatar(
                                size: Size(size ?? 24, size ?? 24),
                                member: e,
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              if (showInviteButton)
                Icon(
                  Icons.ios_share_sharp,
                ),
            ],
          ));
    });
  }
}
