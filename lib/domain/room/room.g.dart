// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Room _$_$_RoomFromJson(Map<String, dynamic> json) {
  return _$_Room(
    id: json['id'] as String,
    memberCount: json['memberCount'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$_$_RoomToJson(_$_Room instance) => <String, dynamic>{
      'id': instance.id,
      'memberCount': instance.memberCount,
      'createdAt': instance.createdAt.toIso8601String(),
    };
