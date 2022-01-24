import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/dynamic_links.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/widgets/common/displays/member_count.dart';
import 'package:tenders/widgets/common/displays/restaurant_row.dart';
import 'package:tenders/widgets/routes/room/summary.dart';
import 'package:tenders/widgets/routes/room/view_qr_code.dart';

class RoomDrawer extends StatelessWidget {
  final bool allowViewAll;
  const RoomDrawer({this.allowViewAll = true});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ViewQRCode(),
                MemberCount(),
                Divider(),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Perfect Matches:",
                  style: Theme.of(context).textTheme.subtitle1!,
                ),
                Expanded(
                  child: BlocBuilder<RoomCubit, RoomState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return RestaurantRow(state.matches[index]);
                        },
                        itemCount: state.matches.length,
                      );
                    },
                  ),
                ),
                if (allowViewAll)
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => Scaffold(
                                body: BlocProvider.value(
                                  value: GetIt.I<RoomAuthCubit>()
                                      .state
                                      .currentRoomCubit!,
                                  child: SummaryWidget(
                                    standalone: true,
                                  ),
                                ),
                              ),
                          fullscreenDialog: true),
                    ),
                    child: Text("View Room Stats"),
                  ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () =>
                      BlocProvider.of<RoomAuthCubit>(context).leaveRoom(),
                  child: Text("Leave"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
