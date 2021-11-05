import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/room/room.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit({required Room room, required Member me})
      : super(RoomState(room: room, me: me));
}
