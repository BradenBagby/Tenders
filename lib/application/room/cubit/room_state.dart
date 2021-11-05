part of 'room_cubit.dart';

@freezed
class RoomState with _$RoomState {
  const factory RoomState({
    required Room room,
    required Member me,
    // if this room was closed
    @Default(false) bool closed,
  }) = _RoomState;
}
