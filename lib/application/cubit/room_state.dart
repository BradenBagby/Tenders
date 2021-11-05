part of 'room_cubit.dart';

@freezed
class RoomState with _$RoomState {
  const factory RoomState({
    /// current room you are in (if any)
    @Default(null) Room? currentRoom,

    /// your member reference while in the room (if any)
    @Default(null) Member? myMember,
    // TODO: here we can keep list of matches
  }) = _RoomState;
}
