import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/services/implementation/room.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

/// TODO: listen to current room changes. if room ends then kick out with message
/// if room finds a match, display the match overtop everything
class RoomCubit extends Cubit<RoomState> {
  IRoom _roomService;
  RoomCubit({required IRoom roomService})
      : _roomService = roomService,
        super(const RoomState()) {}

  /// create a room, auto joins after
  Future<bool> createRoom() async {
    if (state.currentRoom != null) {
      // TODO: alert dialog for already being in a room
      return false;
    }
    try {
      final newRoom = await _roomService.create();
      return joinRoom(newRoom.id);
    } catch (er) {
      // TODO: alert dialog for failing to create a room
      return false;
    }
  }

  /// join a room by id
  Future<bool> joinRoom(String id) async {
    try {
      final info = await _roomService.join(id);
      emit(state.copyWith(myMember: info.item1, currentRoom: info.item2));
      return true;
    } catch (er) {
      // TODO:
      return false;
    }
  }
}
