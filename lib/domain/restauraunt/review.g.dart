// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Review _$_$_ReviewFromJson(Map<String, dynamic> json) {
  return _$_Review(
    author_name: json['author_name'] as String,
    profile_photo_url: json['profile_photo_url'] as String,
    rating: (json['rating'] as num).toDouble(),
    relative_time_description: json['relative_time_description'] as String,
    text: json['text'] as String,
    time: DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$_$_ReviewToJson(_$_Review instance) => <String, dynamic>{
      'author_name': instance.author_name,
      'profile_photo_url': instance.profile_photo_url,
      'rating': instance.rating,
      'relative_time_description': instance.relative_time_description,
      'text': instance.text,
      'time': instance.time.toIso8601String(),
    };
