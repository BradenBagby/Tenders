part of 'room_cubit.dart';

@freezed
class RoomState with _$RoomState {
  const RoomState._();
  const factory RoomState(
      {required Room room,
      required Member me,
      required List<Member> members,
      @Default(null) LocationData? currentLocation,
      required List<Restauraunt> restauraunts,
      @Default(0) int currentViewIndex,
      // if this room was closed
      @Default(false) bool closed,
      @Default(null) String? pageToken}) = _RoomState;

  /// get current restauraunt to display
  Restauraunt? get currentViewRestauraunt =>
      restauraunts.length > currentViewIndex
          ? restauraunts[currentViewIndex]
          : null;
}
