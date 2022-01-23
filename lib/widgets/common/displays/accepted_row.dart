import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/domain/accepted/accepted.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'package:tenders/widgets/common/displays/restaurant_row.dart';

class AcceptedRow extends StatelessWidget {
  final Accepted accepted;
  const AcceptedRow(this.accepted);
  @override
  Widget build(BuildContext context) {
    final members = BlocProvider.of<RoomCubit>(context).state.members;
    final myMembers = accepted.accepted
        .map((e) => members.firstWhere((element) => element.id == e));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          RestaurantRow(
            accepted.restaurant,
            perfectMatch: myMembers.length == members.length,
          ),
          Row(
            children: [
              ...myMembers.map((e) => Avatar(member: e)).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
