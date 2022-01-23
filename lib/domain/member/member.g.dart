// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Member _$_$_MemberFromJson(Map<String, dynamic> json) {
  return _$_Member(
    id: json['id'] as String,
    disconnected: json['disconnected'] as bool? ?? false,
    name: json['name'] as String? ?? 'user',
    avatarUrl: json['avatarUrl'] as String?,
  );
}

Map<String, dynamic> _$_$_MemberToJson(_$_Member instance) => <String, dynamic>{
      'id': instance.id,
      'disconnected': instance.disconnected,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };
