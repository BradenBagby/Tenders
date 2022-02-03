import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/core/utility/environment.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';

part 'photo.freezed.dart';

@freezed
class Photo with _$Photo {
  @JsonSerializable(explicitToJson: true)
  factory Photo({
    @Default(0) int height,
    @Default(0) int width,
    @Default("") String photoReference,
    @Default([]) List<String> htmlAttributions,
  }) = _Photo;

  String url() => GetIt.I<IRestauraunt>().urlForPhoto(this);

  factory Photo.fromJson(Map<String, dynamic> json) {
    final height = json['height'] as int? ?? 0;
    final width = json['width'] as int? ?? 0;
    final photoRefernece = json['photo_reference'] as String? ?? 'BAD';
    final htmlAttributions = List<String>.from(json['html_attributions']);
    if (Environment.marketing) {
      return FakePhoto(fakeUrl: photoRefernece);
    }
    return Photo(
        photoReference: photoRefernece,
        height: height,
        width: width,
        htmlAttributions: htmlAttributions);
  }
  const Photo._();

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      "width": width,
      'html_attributions': htmlAttributions,
      'photo_reference': photoReference,
    };
  }
}

/// for marketing
class FakePhoto extends Photo {
  final String fakeUrl;
  FakePhoto({required this.fakeUrl}) : super._();
  @override
  String url({int? maxWidth, int? maxHeight}) => fakeUrl;
  @override
  int get height => 0;
  @override
  int get width => 0;
  @override
  String get photoReference => fakeUrl;
}
