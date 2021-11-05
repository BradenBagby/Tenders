part of 'room_cubit.dart';

@freezed
class RoomState with _$RoomState {
  const factory RoomState({required Room room, required Member me}) =
      _RoomState;
}
