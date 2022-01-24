import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/domain/restauraunt/review.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

part 'restauraunt.freezed.dart';
part 'restauraunt.g.dart';

@freezed
class Restauraunt with _$Restauraunt {
  @JsonSerializable(explicitToJson: true)
  factory Restauraunt({
    required String name,
    required String id,
    required String address,
    required double rating,
    required String iconUrl,
    required double latitude,
    required double longitude,
    String? website,
    required String url,
    required String formattedPhoneNumber,
    int? priceLevel,
    @Default(0) int totalRatings,
    @Default([]) List<Photo> photos,
    @Default(false) bool opennow,
    @Default([]) List<String> hoursText,
    @Default([]) List<Review> reviews,
  }) = _Restauraunt;

  const Restauraunt._();
  factory Restauraunt.fromJson(Map<String, dynamic> json) =>
      _$RestaurauntFromJson(json);

  factory Restauraunt.fromGoogleJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final id = json['place_id'] as String;
    final address = json['vicinity'] as String;
    final rating = json['rating'] as num? ?? 0;
    final iconUrl = json['icon'] as String;
    final photos = json.containsKey('photos')
        ? toList(json['photos']).map((e) => Photo.fromJson(e)).toList()
        : <Photo>[];
    final geometry = toMap(json['geometry']);
    final location = toMap(geometry['location']);
    final latitude = location['lat'] as double;
    final longitude = location['lng'] as double;
    final hoursInfo =
        json.containsKey('opening_hours') ? toMap(json['opening_hours']) : {};
    final opennow = hoursInfo['open_now'] as bool? ?? false;
    final hoursText = hoursInfo.containsKey('weekday_text')
        ? List<String>.from(hoursInfo['weekday_text'])
        : <String>[];
    final totalRatings = json['user_ratings_total'] as int? ?? 0;
    final priceLevel = json['price_level'] as int?;
    final reviews = json.containsKey('reviews')
        ? toList(json['reviews']).map((e) => Review.fromJson(e)).toList()
        : <Review>[];
    final website = json['website'] as String?;
    final url = json['url'] as String? ?? '';
    final phone = json['formatted_phone_number'] as String? ?? '';

    // precache first image
    if (photos.isNotEmpty) {
      DefaultCacheManager()
          .downloadFile(photos.first.url(maxHeight: 1200, maxWidth: 800));
    }
    return Restauraunt(
        name: name,
        url: url,
        id: id,
        website: website,
        totalRatings: totalRatings,
        reviews: reviews,
        address: address,
        priceLevel: priceLevel,
        formattedPhoneNumber: phone,
        photos: photos,
        rating: rating.toDouble(),
        latitude: latitude,
        opennow: opennow,
        hoursText: hoursText,
        longitude: longitude,
        iconUrl: iconUrl);
  }
}
