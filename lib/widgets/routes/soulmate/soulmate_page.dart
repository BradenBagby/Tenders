import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/share.dart';
import 'package:tenders/domain/accepted/accepted.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';
import 'package:tenders/widgets/root_widget.dart';
import 'package:collection/collection.dart';
import 'dart:math' as math;

class SoulmatePage extends StatefulWidget {
  final Accepted soulmate;
  final bool embedded;
  const SoulmatePage(this.soulmate, {this.embedded = false});

  @override
  State<SoulmatePage> createState() => _SoulmatePageState();
}

class _SoulmatePageState extends State<SoulmatePage> {
  final globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final members =
        GetIt.I<RoomAuthCubit>().state.currentRoomCubit!.state.members;
    final myMembers = widget.soulmate.accepted
        .map((e) => members.firstWhere((element) => element.id == e));
    final percent =
        (myMembers.length.toDouble() / members.length.toDouble()) * 100;

    final size = MediaQuery.of(context).size;

    final memberSize = members.length;
    final fullRange = math.pi; // we want top half of circle
    final spacing = fullRange / (memberSize + 1);
    double current = spacing;
    final spaces = List.generate(memberSize, (x) {
      final res = current;
      current += spacing;
      return res;
    });

    final soulmateDiameter = size.width * 0.5;
    final arcDiameter = 32.0;
    final arcRadius =
        (soulmateDiameter / 2) + arcDiameter + 8.0; //8.0 for padding

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Center(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Soulmate",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      fontSize: size.height < 700 ? 50 : 64,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${percent.toStringAsFixed(0)}% match",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      fontSize: size.height < 700 ? 25 : 32,
                                      color: Color(0xff9F2B00),
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ))),
                        SizedBox(
                          width: soulmateDiameter,
                          height: soulmateDiameter,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipOval(
                                  child: URLImage(widget
                                      .soulmate.restaurant.photos.first
                                      .url(maxWidth: 800, maxHeight: 1200)),
                                ),
                              ),
                              ...spaces.map((angle) {
                                final y = math.sin(angle) * arcRadius;
                                final x = math.cos(angle) * arcRadius;
                                final index = spaces.indexOf(angle);
                                final member = members[index];
                                final didVote = myMembers.firstWhereOrNull(
                                        (element) => element.id == member.id) !=
                                    null;
                                return Center(
                                  child: Transform.translate(
                                    offset: Offset(x, -y),
                                    child: Opacity(
                                      opacity: didVote ? 1.0 : 0.4,
                                      child: SizedBox(
                                        width: arcDiameter,
                                        height: arcDiameter,
                                        child: Avatar(
                                          member: member,
                                          size: Size(arcDiameter, arcDiameter),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.soulmate.restaurant.name,
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.white,
                                  ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      borderRadius: BorderRadius.circular(4),
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child:
                                            Image.asset("assets/appIcon.jpg"),
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
                            )
                          ],
                        ))
                      ],
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
                      Share.shareWidget(key: globalKey);
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
}
