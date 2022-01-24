import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/domain/accepted/accepted.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'package:tenders/widgets/common/displays/restaurant_row.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';

class AcceptedRow extends StatelessWidget {
  final Accepted accepted;
  const AcceptedRow(this.accepted);
  @override
  Widget build(BuildContext context) {
    final members = BlocProvider.of<RoomCubit>(context).state.members;
    final myMembers = accepted.accepted
        .map((e) => members.firstWhere((element) => element.id == e));
    final percent =
        (myMembers.length.toDouble() / members.length.toDouble()) * 100;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            RootRouteController.showMatch(
                RootRouteController.key.currentContext!,
                restauraunt: accepted.restaurant,
                perfectMatch: myMembers.length == members.length);
          },
          child: Container(
            height: 200,
            child: Stack(
              children: [
                if (accepted.restaurant.photos.isNotEmpty)
                  Positioned.fill(
                      child: URLImage(accepted.restaurant.photos.first
                          .url(maxWidth: 800, maxHeight: 1200))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.black.withAlpha(150),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          accepted.restaurant.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              children: [
                                ...myMembers
                                    .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Avatar(member: e),
                                        ))
                                    .toList(),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                "${percent.toStringAsFixed(0)}%",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
