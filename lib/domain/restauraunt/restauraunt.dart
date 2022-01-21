import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/domain/restauraunt/review.dart';
import 'package:tuple/tuple.dart';

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
        ? toList(hoursInfo['weekday_text']) as List<String>
        : <String>[];
    return Restauraunt(
        name: name,
        id: id,
        address: address,
        photos: photos,
        rating: rating.toDouble(),
        latitude: latitude,
        opennow: opennow,
        hoursText: hoursText,
        longitude: longitude,
        iconUrl: iconUrl);
  }
}
