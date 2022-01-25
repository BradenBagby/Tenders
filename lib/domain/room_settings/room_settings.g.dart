// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Room _$_$_RoomFromJson(Map<String, dynamic> json) {
  return _$_Room(
    radius: json['radius'] as int,
    type: _$enumDecode(_$PlaceTypeEnumMap, json['type']),
    openNow: json['openNow'] as bool,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$_$_RoomToJson(_$_Room instance) => <String, dynamic>{
      'radius': instance.radius,
      'type': _$PlaceTypeEnumMap[instance.type],
      'openNow': instance.openNow,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$PlaceTypeEnumMap = {
  PlaceType.RESTAURAT: 'RESTAURANT',
  PlaceType.FOOD: 'FOOD',
  PlaceType.DRINKS: 'DRINKS',
  PlaceType.BAKERY: 'BAKERY',
  PlaceType.BAR: 'BAR',
  PlaceType.CAFE: 'CAFE',
};
