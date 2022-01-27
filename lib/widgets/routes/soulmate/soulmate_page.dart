import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/core/utility/share.dart';
import 'package:tenders/domain/accepted/accepted.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';
import 'package:tenders/widgets/root_widget.dart';
import 'package:collection/collection.dart';
import 'dart:math' as math;

import 'package:tenders/widgets/routes/soulmate/soulmate_info.dart';

class SoulmatePage extends StatefulWidget {
  final Accepted soulmate;
  final bool embedded;
  final bool autoShare;
  const SoulmatePage(this.soulmate,
      {this.embedded = false, this.autoShare = false});

  @override
  State<SoulmatePage> createState() => _SoulmatePageState();
}

class _SoulmatePageState extends State<SoulmatePage> {
  final globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.autoShare) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
        await Future.delayed(const Duration(milliseconds: 1000));
        _share();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: InkWell(
              onTap: () {
                final members = GetIt.I<RoomAuthCubit>()
                    .state
                    .currentRoomCubit!
                    .state
                    .members;
                final myMembers = widget.soulmate.accepted
                    .where((element) =>
                        members.firstWhereOrNull((e) => e.id == element) !=
                        null)
                    .map((e) =>
                        members.firstWhere((element) => element.id == e));
                final percent =
                    (myMembers.length.toDouble() / members.length.toDouble()) *
                        100;
                RootRouteController.showMatch(
                    RootRouteController.key.currentContext!,
                    restauraunt: widget.soulmate.restaurant,
                    perfectMatch: myMembers.length == members.length);
              },
              child: RepaintBoundary(
                key: globalKey,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [primaryColor, secondaryColor])),
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: SoulmateInfo(widget.soulmate),
                            flex: 3,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(100),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Tenders App",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Image.asset(
                                                "assets/appIcon.jpg"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Swipe - decide where to eat",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontSize: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .fontSize! *
                                              0.8,
                                          color: Colors.black.withAlpha(150)),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _share();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Share",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    )),
                SizedBox(
                  height: 110,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _share() {
    Share.shareWidget(key: globalKey);
  }
}
