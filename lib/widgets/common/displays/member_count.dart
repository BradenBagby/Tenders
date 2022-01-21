import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';

class MemberCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
      return Wrap(
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
              .toList()
        ],
      );
    });
  }
}
