import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/domain/accepted/accepted.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';
import 'package:tenders/widgets/common/displays/accepted_row.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'package:tenders/widgets/common/displays/restaurant_row.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';

class SummaryWidget extends StatefulWidget {
  final bool standalone;
  const SummaryWidget({this.standalone = false});
  @override
  State<SummaryWidget> createState() => _SummaryState();
}

class _SummaryState extends State<SummaryWidget> {
  List<Accepted>? accepted;

  @override
  void initState() {
    final currentroom =
        GetIt.I<RoomAuthCubit>().state.currentRoomCubit!.state.room;
    GetIt.I<IRoom>().getAllAccepted(currentroom.id).then((value) {
      setState(() {
        accepted = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
        )),
        Positioned.fill(
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/stcharles.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  color: Theme.of(context).colorScheme.onBackground,
                  onPressed: () {
                    if (widget.standalone) {
                      Navigator.of(context).pop();
                    } else {
                      Scaffold.of(context).openDrawer();
                    }
                  },
                  icon: Icon(
                    widget.standalone ? Icons.close : Icons.menu,
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
              elevation: 0,
              title: Text(
                "SUMMARY",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            body: SafeArea(
                child: Column(
              children: [
                BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
                  final Accepted? soulmate = accepted?.firstOrNull;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (soulmate != null)
                          InkWell(
                            onTap: () {
                              final members = state.members;
                              final myMembers = soulmate.accepted.map((e) =>
                                  members.firstWhere(
                                      (element) => element.id == e));
                              final percent = (myMembers.length.toDouble() /
                                      members.length.toDouble()) *
                                  100;
                              RootRouteController.showMatch(
                                  RootRouteController.key.currentContext!,
                                  restauraunt: soulmate.restaurant,
                                  perfectMatch:
                                      myMembers.length == members.length);
                            },
                            child: Column(
                              children: [
                                Divider(),
                                Text(
                                  "Soul Mate:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        if (soulmate
                                            .restaurant.photos.isNotEmpty)
                                          ClipOval(
                                            child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: URLImage(soulmate
                                                  .restaurant.photos.first
                                                  .url(
                                                      maxHeight: 1200,
                                                      maxWidth: 800)),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          ),
                        if (state.room.settings.locationString != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text("${state.room.settings.locationString!}:"),
                          ),
                        ...state.members
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Avatar(member: e),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(e.name),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      if (accepted != null)
                                        Text(
                                          "- ${accepted!.where((element) => element.accepted.contains(e.id)).length} Swipes Right",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        )
                                    ],
                                  ),
                                ))
                            .toList(),
                      ]);
                }),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                Expanded(
                  child: accepted == null
                      ? _loadingSummary()
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return AcceptedRow(accepted![
                                index]); // TOOD: members that accepted
                          },
                          itemCount: accepted!.length,
                        ),
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  Widget _loadingSummary() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Loading Summary", style: Theme.of(context).textTheme.headline4),
          SizedBox(
            height: 8,
          ),
          Loader()
        ],
      ),
    );
  }
}
