part of 'room_cubit.dart';

@freezed
class RoomState with _$RoomState {
  const RoomState._();
  const factory RoomState({
    required Room room,
    required Member me,
    required List<Member> members,
    @Default(null) LocationData? currentLocation,
    required List<Restauraunt> restauraunts,
    @Default(0) int currentViewIndex,
    // if this room was closed
    @Default(false) bool closed,
    @Default(true) bool hasMoreToLoad,
    @Default(false) bool showNeedsLocation,
    @Default([]) List<Restauraunt> matches,

    /// have we loaded anything
    @Default(false) bool hasLoaded,
  }) = _RoomState;

  /// get current restauraunt to display
  Restauraunt? get currentViewRestauraunt =>
      restauraunts.length > currentViewIndex
          ? restauraunts[currentViewIndex]
          : null;

  bool get outOfRestauraunts =>
      hasLoaded && !hasMoreToLoad && restauraunts.length <= currentViewIndex;

  bool get noResults => hasLoaded && !hasMoreToLoad && restauraunts.isEmpty;
}
