// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restauraunt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Restauraunt _$_$_RestaurauntFromJson(Map<String, dynamic> json) {
  return _$_Restauraunt(
    name: json['name'] as String,
    id: json['id'] as String,
    address: json['address'] as String,
    rating: (json['rating'] as num).toDouble(),
    iconUrl: json['iconUrl'] as String,
  );
}

Map<String, dynamic> _$_$_RestaurauntToJson(_$_Restauraunt instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'address': instance.address,
      'rating': instance.rating,
      'iconUrl': instance.iconUrl,
    };