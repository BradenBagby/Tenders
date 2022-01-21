// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  @JsonSerializable(explicitToJson: true)
  factory Review({
    required String author_name,
    required String profile_photo_url,
    required double rating,
    required String relative_time_description,
    required String text,
    required DateTime time,
  }) = _Review;
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
