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
        return "Restaurants";
      case PlaceType.FOOD:
        return "Food";
      case PlaceType.DRINKS:
        return "Drinks";
      case PlaceType.BAKERY:
        return "Bakeries";
      case PlaceType.BAR:
        return "Bars";
      case PlaceType.CAFE:
        return "Cafés";
    }
  }
}

@freezed
class RoomSettings with _$RoomSettings {
  factory RoomSettings({
    required int radius,
    required PlaceType type,
    required bool openNow,
    required double latitude,
    required double longitude,
    @Default(null) String? locationString,
    @Default("food") String query,
  }) = _Room;
  factory RoomSettings.fromJson(Map<String, dynamic> json) =>
      _$RoomSettingsFromJson(json);
}
