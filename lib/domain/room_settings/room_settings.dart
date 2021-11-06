import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_settings.freezed.dart';
part 'room_settings.g.dart';

enum PlaceType {
  @JsonValue("RESTAURAUNT")
  RESTAURAUNT,
  @JsonValue("FOOD")
  FOOD,
  @JsonValue("DRINKS")
  DRINKS,
}

extension PlaceTypeString on PlaceType {
  String toQueryString() {
    switch (this) {
      case PlaceType.RESTAURAUNT:
        return "restauraunt";
      case PlaceType.FOOD:
        return "food";
      case PlaceType.DRINKS:
        return "drinks"; // TODO:
    }
  }
}

@freezed
class RoomSettings with _$RoomSettings {
  factory RoomSettings(
      {required int radius,
      required PlaceType type,
      required bool openNow}) = _Room;
  factory RoomSettings.fromJson(Map<String, dynamic> json) =>
      _$RoomSettingsFromJson(json);
}
