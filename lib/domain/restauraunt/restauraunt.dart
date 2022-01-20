import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/restauraunt/photo.dart';

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
    @Default([]) List<Photo> photos,
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
    return Restauraunt(
        name: name,
        id: id,
        address: address,
        photos: photos,
        rating: rating.toDouble(),
        iconUrl: iconUrl);
  }
}
