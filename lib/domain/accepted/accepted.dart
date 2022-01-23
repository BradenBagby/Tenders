import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';

part 'accepted.freezed.dart';
part 'accepted.g.dart';

/// wrapper for accepted info on a restauraunt
@freezed
class Accepted with _$Accepted {
  factory Accepted({
    /// ids of members that accepted this one
    required List<String> accepted,
    required Restauraunt restaurant,
  }) = _Accepted;
  factory Accepted.fromJson(Map<String, dynamic> json) =>
      _$AcceptedFromJson(json);
}
