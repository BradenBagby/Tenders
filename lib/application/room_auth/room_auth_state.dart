part of 'room_auth_cubit.dart';

@freezed
class RoomAuthState with _$RoomAuthState {
  const factory RoomAuthState({
    /// current room you are in (if any)
    @Default(null) RoomCubit? currentRoomCubit,

    /// my memer info
    @Default(null) Member? me,
  }) = _RoomAuthState;
  const RoomAuthState._();
}
