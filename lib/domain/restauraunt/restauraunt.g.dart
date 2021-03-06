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
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    website: json['website'] as String?,
    url: json['url'] as String,
    formattedPhoneNumber: json['formattedPhoneNumber'] as String,
    priceLevel: json['priceLevel'] as int?,
    totalRatings: json['totalRatings'] as int? ?? 0,
    photos: (json['photos'] as List<dynamic>?)
            ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    opennow: json['opennow'] as bool? ?? false,
    hoursText: (json['hoursText'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    reviews: (json['reviews'] as List<dynamic>?)
            ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_RestaurauntToJson(_$_Restauraunt instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'address': instance.address,
      'rating': instance.rating,
      'iconUrl': instance.iconUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'website': instance.website,
      'url': instance.url,
      'formattedPhoneNumber': instance.formattedPhoneNumber,
      'priceLevel': instance.priceLevel,
      'totalRatings': instance.totalRatings,
      'photos': instance.photos.map((e) => e.toJson()).toList(),
      'opennow': instance.opennow,
      'hoursText': instance.hoursText,
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
    };
