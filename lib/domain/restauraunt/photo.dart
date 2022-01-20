import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';

part 'photo.freezed.dart';

@freezed
class Photo with _$Photo {
  const Photo._();
  factory Photo({
    @Default(0) int height,
    @Default(0) int width,
    required String photoReference,
  }) = _Photo;

  String url({int? maxWidth, int? maxHeight}) => GetIt.I<IRestauraunt>()
      .urlForPhoto(this, maxHeight: maxHeight, maxWidth: maxWidth);

  factory Photo.fromJson(Map<String, dynamic> json) {
    final height = json['height'] as int? ?? 0;
    final width = json['width'] as int? ?? 0;
    final photoRefernece = json['photo_reference'] as String? ?? 'BAD';
    return Photo(photoReference: photoRefernece, height: height, width: width);
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      "width": width,
      'photo_reference': photoReference,
    };
  }
}
