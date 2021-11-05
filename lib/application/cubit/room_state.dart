part of 'room_cubit.dart';

@freezed
class RoomState with _$RoomState {
  const factory RoomState({
    @Default(null) Room? currentRoom,
    // TODO: here we can keep list of matches
  }) = _RoomState;
}
