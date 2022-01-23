// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accepted.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Accepted _$_$_AcceptedFromJson(Map<String, dynamic> json) {
  return _$_Accepted(
    accepted:
        (json['accepted'] as List<dynamic>).map((e) => e as String).toList(),
    restaurant:
        Restauraunt.fromJson(json['restaurant'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_AcceptedToJson(_$_Accepted instance) =>
    <String, dynamic>{
      'accepted': instance.accepted,
      'restaurant': instance.restaurant,
    };
