import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/accepted/accepted.dart';
import 'package:collection/collection.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'dart:math' as math;

import 'package:tenders/widgets/common/displays/url_image.dart';

class SoulmateInfo extends StatelessWidget {
  final Accepted soulmate;
  final double sizeMultiplier;
  const SoulmateInfo(this.soulmate, {this.sizeMultiplier = 1.0});
  @override
  Widget build(BuildContext context) {
    final members =
        GetIt.I<RoomAuthCubit>().state.currentRoomCubit!.state.members;
    final myMembers = soulmate.accepted
        .where((element) =>
            members.firstWhereOrNull((e) => e.id == element) != null)
        .map((e) => members.firstWhere((element) => element.id == e));
    final percent =
        (myMembers.length.toDouble() / members.length.toDouble()) * 100;

    final size = MediaQuery.of(context).size * sizeMultiplier;

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
    final arcDiameter = 32.0 * sizeMultiplier;
    final arcRadius =
        (soulmateDiameter / 2) + arcDiameter + 8.0; //8.0 for padding
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Soulmate",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: (size.height < 700 ? 50 : 64) * sizeMultiplier,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${percent.toStringAsFixed(0)}% match",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: (size.height < 700 ? 25 : 32) * sizeMultiplier,
                      color: Color(0xff9F2B00),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: (arcRadius + arcDiameter) - (soulmateDiameter / 2.0),
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: Column(
          children: [
            SizedBox(
              width: soulmateDiameter,
              height: soulmateDiameter,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipOval(
                      child: soulmate.restaurant.photos.isNotEmpty
                          ? URLImage(soulmate.restaurant.photos.first.url())
                          : Container(
                              color: Colors.black,
                            ),
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
                          opacity: didVote ? 1.0 : 0.1,
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
              soulmate.restaurant.name,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.headline4!.fontSize! *
                      sizeMultiplier),
            ),
          ],
        ))
      ],
    );
  }
}
