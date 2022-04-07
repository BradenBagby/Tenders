import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/domain/restauraunt/review.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';

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

  factory Restauraunt.fromYelpJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final id = json['id'] as String;
    final rating = json['rating'] as num? ?? 0;
    final url = json['url'] as String? ?? '';
    final photos = json.containsKey('photos')
        ? List<String>.from(json['photos'] as Iterable<dynamic>)
            .map((e) => Photo(
                height: 0, width: 0, photoReference: e, htmlAttributions: []))
            .toList()
        : (json.containsKey('image_url')
            ? [
                Photo(
                    height: 0,
                    width: 0,
                    photoReference: json['image_url'] as String,
                    htmlAttributions: [])
              ]
            : <Photo>[]);
    final coordinates = toMap(json['coordinates']);
    final latitude = coordinates['latitude'] as double;
    final longitude = coordinates['longitude'] as double;
    final phone = json['display_phone'] as String? ??
        json['phone'] as String? ??
        ''; // TOOD:
    final totalRatings = json['review_count'] as int? ?? 0;
    final isClosed = json['is_closed'] as bool? ?? false;

    final location = toMap(json['location']);

    List<String> hours = [];
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    if (json.containsKey('hours')) {
      final h = toList(json['hours']);
      if (h.isNotEmpty && toMap(h[0]).containsKey('open')) {
        final open = toList(toMap(h[0])['open']);
        open.forEach((e) {
          try {
            //GIANT MESS BUT IM LAZY RIGHT NOW MAKING TOO MANY APPS AT ONCE
            final d = toMap(e);
            final _d = d['day'] as int;
            final day = days[_d];

            final st = (d['start'] as String);
            final m = st.substring(st.length - 2);
            final h = st.substring(0, st.length - 2);
            int hourInt = int.parse(h);
            bool openPm = false;
            if (hourInt > 12) {
              hourInt = hourInt - 12;
              openPm = true;
            }
            String endTime = '';
            final et = d['end'] as String?;
            if (et != null) {
              final em = st.substring(et.length - 2);
              final eh = st.substring(0, et.length - 2);
              int closehourInt = int.parse(eh);
              bool closePm = false;
              if (closehourInt > 12) {
                closehourInt = closehourInt - 12;
                closePm = true;
              }
              endTime =
                  '${closehourInt.toString()}:$em ${closePm ? 'pm' : 'am'}';
            }

            hours.add(
                '$day ${hourInt.toString()}:$m ${openPm ? 'pm' : 'am'}${endTime == null ? '' : ' - $endTime'}');
          } catch (err) {}
        });
      }
    }
    /*
"location": {
        "city": "San Francisco",
        "country": "US",
        "address2": "",
        "address3": "",
        "state": "CA",
        "address1": "375 Valencia St",
        "zip_code": "94103"
      }
    */
    final address = location['address1'] as String;
    return Restauraunt(
        name: name,
        id: id,
        hoursText: hours,
        address: address,
        rating: rating.toDouble(),
        iconUrl: '',
        latitude: latitude,
        longitude: longitude,
        url: url,
        formattedPhoneNumber: phone,
        totalRatings: totalRatings,
        opennow: !isClosed,
        photos: photos);
  }

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
