import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tenders/services/implementation/room.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_auth_state.dart';
part 'room_auth_cubit.freezed.dart';

//// manages authentication on a room
/// creates and closes dependent cubits on the room
class RoomAuthCubit extends Cubit<RoomAuthState> {
  IRoom _roomService;
  RoomAuthCubit({required IRoom roomService})
      : _roomService = roomService,
        super(const RoomAuthState()) {}

  /// create a room, auto joins after
  Future<bool> createRoom({required RoomSettings settings}) async {
    if (state.currentRoomCubit != null) {
      // TODO: alert dialog for already being in a room
      return false;
    }
    try {
      final newRoom = await _roomService.create(settings: settings);
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
      final cubit = RoomCubit(room: info.item2, me: info.item1);
      emit(state.copyWith(currentRoomCubit: cubit));
      return true;
    } catch (er) {
      // TODO:
      return false;
    }
  }

  Future<bool> leaveRoom() async {
    final currentRoom = state.currentRoomCubit?.state.room;
    final currentUser = state.currentRoomCubit?.state.me;
    state.currentRoomCubit?.close();
    emit(state.copyWith(currentRoomCubit: null));
    if (currentRoom != null && currentUser != null) {
      await _roomService.leave(currentUser, currentRoom.id);
    }
    return true;
  }
}
