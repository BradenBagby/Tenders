import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_settings.freezed.dart';
part 'room_settings.g.dart';

enum PlaceType {
  @JsonValue("RESTAURANT")
  RESTAURAT,
  @JsonValue("FOOD")
  FOOD,
  @JsonValue("DRINKS")
  DRINKS,
  @JsonValue("BAKERY")
  BAKERY,
  @JsonValue("BAR")
  BAR,
  @JsonValue("CAFE")
  CAFE,
}

extension PlaceTypeString on PlaceType {
  static PlaceType fromUIString(String string) {
    final res = PlaceType.values
        .firstWhere((element) => element.toUIString() == string);
    return res;
  }

  String toQueryString() {
    switch (this) {
      case PlaceType.RESTAURAT:
        return "restaurant";
      case PlaceType.FOOD:
        return "food";
      case PlaceType.DRINKS:
        return "drinks"; // TODO:
      case PlaceType.BAKERY:
        return "bakery";
      case PlaceType.BAR:
        return "bar";
      case PlaceType.CAFE:
        return "cafe";
    }
  }

  String toUIString() {
    switch (this) {
      case PlaceType.RESTAURAT:
        return "Restaurant";
      case PlaceType.FOOD:
        return "Food";
      case PlaceType.DRINKS:
        return "Drinks";
      case PlaceType.BAKERY:
        return "Bakery";
      case PlaceType.BAR:
        return "Bar";
      case PlaceType.CAFE:
        return "Cafe";
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
