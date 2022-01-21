// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
class _$ReviewTearOff {
  const _$ReviewTearOff();

  _Review call(
      {required String author_name,
      required String profile_photo_url,
      required double rating,
      required String relative_time_description,
      required String text}) {
    return _Review(
      author_name: author_name,
      profile_photo_url: profile_photo_url,
      rating: rating,
      relative_time_description: relative_time_description,
      text: text,
    );
  }

  Review fromJson(Map<String, Object> json) {
    return Review.fromJson(json);
  }
}

/// @nodoc
const $Review = _$ReviewTearOff();

/// @nodoc
mixin _$Review {
  String get author_name => throw _privateConstructorUsedError;
  String get profile_photo_url => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get relative_time_description => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res>;
  $Res call(
      {String author_name,
      String profile_photo_url,
      double rating,
      String relative_time_description,
      String text});
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res> implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  final Review _value;
  // ignore: unused_field
  final $Res Function(Review) _then;

  @override
  $Res call({
    Object? author_name = freezed,
    Object? profile_photo_url = freezed,
    Object? rating = freezed,
    Object? relative_time_description = freezed,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      author_name: author_name == freezed
          ? _value.author_name
          : author_name // ignore: cast_nullable_to_non_nullable
              as String,
      profile_photo_url: profile_photo_url == freezed
          ? _value.profile_photo_url
          : profile_photo_url // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      relative_time_description: relative_time_description == freezed
          ? _value.relative_time_description
          : relative_time_description // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$ReviewCopyWith(_Review value, $Res Function(_Review) then) =
      __$ReviewCopyWithImpl<$Res>;
  @override
  $Res call(
      {String author_name,
      String profile_photo_url,
      double rating,
      String relative_time_description,
      String text});
}

/// @nodoc
class __$ReviewCopyWithImpl<$Res> extends _$ReviewCopyWithImpl<$Res>
    implements _$ReviewCopyWith<$Res> {
  __$ReviewCopyWithImpl(_Review _value, $Res Function(_Review) _then)
      : super(_value, (v) => _then(v as _Review));

  @override
  _Review get _value => super._value as _Review;

  @override
  $Res call({
    Object? author_name = freezed,
    Object? profile_photo_url = freezed,
    Object? rating = freezed,
    Object? relative_time_description = freezed,
    Object? text = freezed,
  }) {
    return _then(_Review(
      author_name: author_name == freezed
          ? _value.author_name
          : author_name // ignore: cast_nullable_to_non_nullable
              as String,
      profile_photo_url: profile_photo_url == freezed
          ? _value.profile_photo_url
          : profile_photo_url // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      relative_time_description: relative_time_description == freezed
          ? _value.relative_time_description
          : relative_time_description // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable(explicitToJson: true)

/// @nodoc
class _$_Review implements _Review {
  _$_Review(
      {required this.author_name,
      required this.profile_photo_url,
      required this.rating,
      required this.relative_time_description,
      required this.text});

  factory _$_Review.fromJson(Map<String, dynamic> json) =>
      _$_$_ReviewFromJson(json);

  @override
  final String author_name;
  @override
  final String profile_photo_url;
  @override
  final double rating;
  @override
  final String relative_time_description;
  @override
  final String text;

  @override
  String toString() {
    return 'Review(author_name: $author_name, profile_photo_url: $profile_photo_url, rating: $rating, relative_time_description: $relative_time_description, text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Review &&
            (identical(other.author_name, author_name) ||
                const DeepCollectionEquality()
                    .equals(other.author_name, author_name)) &&
            (identical(other.profile_photo_url, profile_photo_url) ||
                const DeepCollectionEquality()
                    .equals(other.profile_photo_url, profile_photo_url)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.relative_time_description,
                    relative_time_description) ||
                const DeepCollectionEquality().equals(
                    other.relative_time_description,
                    relative_time_description)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(author_name) ^
      const DeepCollectionEquality().hash(profile_photo_url) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(relative_time_description) ^
      const DeepCollectionEquality().hash(text);

  @JsonKey(ignore: true)
  @override
  _$ReviewCopyWith<_Review> get copyWith =>
      __$ReviewCopyWithImpl<_Review>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ReviewToJson(this);
  }
}

abstract class _Review implements Review {
  factory _Review(
      {required String author_name,
      required String profile_photo_url,
      required double rating,
      required String relative_time_description,
      required String text}) = _$_Review;

  factory _Review.fromJson(Map<String, dynamic> json) = _$_Review.fromJson;

  @override
  String get author_name => throw _privateConstructorUsedError;
  @override
  String get profile_photo_url => throw _privateConstructorUsedError;
  @override
  double get rating => throw _privateConstructorUsedError;
  @override
  String get relative_time_description => throw _privateConstructorUsedError;
  @override
  String get text => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ReviewCopyWith<_Review> get copyWith => throw _privateConstructorUsedError;
}
