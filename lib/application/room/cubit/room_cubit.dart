import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/services/interfaces/i_room.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

class RoomCubit extends Cubit<RoomState> {
  StreamSubscription<Room?>? roomDataStreamSubscription;
  RoomCubit({required Room room, required Member me})
      : super(RoomState(room: room, me: me)) {
    // listen to room updates and update state accordinly
    roomDataStreamSubscription =
        GetIt.I<IRoom>().roomUpdates(room.id).listen((event) {
      if (event == null) {
        emit(state.copyWith(
            closed:
                true)); // TODO: listen top layer for closed and show ui for it
      } else {
        emit(state.copyWith(room: event));
      }
    });
  }

  @override
  Future<void> close() {
    roomDataStreamSubscription?.cancel();
    return super.close();
  }
}
