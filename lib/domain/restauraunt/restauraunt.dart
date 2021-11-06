import 'package:freezed_annotation/freezed_annotation.dart';

part 'restauraunt.freezed.dart';
part 'restauraunt.g.dart';

@freezed
class Restauraunt with _$Restauraunt {
  const Restauraunt._();
  factory Restauraunt(
      {required String name,
      required String id,
      required String address,
      required double rating,
      required String iconUrl}) = _Restauraunt;
  factory Restauraunt.fromJson(Map<String, dynamic> json) =>
      _$RestaurauntFromJson(json);

  factory Restauraunt.fromGoogleJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final id = json['place_id'] as String;
    final address = json['vicinity'] as String;
    final rating = json['rating'] as num? ?? 0;
    final iconUrl = json['icon'] as String;
    return Restauraunt(
        name: name,
        id: id,
        address: address,
        rating: rating.toDouble(),
        iconUrl: iconUrl);
  }
}
