// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'restauraunt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Restauraunt _$RestaurauntFromJson(Map<String, dynamic> json) {
  return _Restauraunt.fromJson(json);
}

/// @nodoc
class _$RestaurauntTearOff {
  const _$RestaurauntTearOff();

  _Restauraunt call(
      {required String name,
      required String id,
      required String address,
      required double rating,
      required String iconUrl}) {
    return _Restauraunt(
      name: name,
      id: id,
      address: address,
      rating: rating,
      iconUrl: iconUrl,
    );
  }

  Restauraunt fromJson(Map<String, Object> json) {
    return Restauraunt.fromJson(json);
  }
}

/// @nodoc
const $Restauraunt = _$RestaurauntTearOff();

/// @nodoc
mixin _$Restauraunt {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get iconUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurauntCopyWith<Restauraunt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurauntCopyWith<$Res> {
  factory $RestaurauntCopyWith(
          Restauraunt value, $Res Function(Restauraunt) then) =
      _$RestaurauntCopyWithImpl<$Res>;
  $Res call(
      {String name, String id, String address, double rating, String iconUrl});
}

/// @nodoc
class _$RestaurauntCopyWithImpl<$Res> implements $RestaurauntCopyWith<$Res> {
  _$RestaurauntCopyWithImpl(this._value, this._then);

  final Restauraunt _value;
  // ignore: unused_field
  final $Res Function(Restauraunt) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? address = freezed,
    Object? rating = freezed,
    Object? iconUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$RestaurauntCopyWith<$Res>
    implements $RestaurauntCopyWith<$Res> {
  factory _$RestaurauntCopyWith(
          _Restauraunt value, $Res Function(_Restauraunt) then) =
      __$RestaurauntCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, String id, String address, double rating, String iconUrl});
}

/// @nodoc
class __$RestaurauntCopyWithImpl<$Res> extends _$RestaurauntCopyWithImpl<$Res>
    implements _$RestaurauntCopyWith<$Res> {
  __$RestaurauntCopyWithImpl(
      _Restauraunt _value, $Res Function(_Restauraunt) _then)
      : super(_value, (v) => _then(v as _Restauraunt));

  @override
  _Restauraunt get _value => super._value as _Restauraunt;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? address = freezed,
    Object? rating = freezed,
    Object? iconUrl = freezed,
  }) {
    return _then(_Restauraunt(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Restauraunt extends _Restauraunt {
  _$_Restauraunt(
      {required this.name,
      required this.id,
      required this.address,
      required this.rating,
      required this.iconUrl})
      : super._();

  factory _$_Restauraunt.fromJson(Map<String, dynamic> json) =>
      _$_$_RestaurauntFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  final String address;
  @override
  final double rating;
  @override
  final String iconUrl;

  @override
  String toString() {
    return 'Restauraunt(name: $name, id: $id, address: $address, rating: $rating, iconUrl: $iconUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Restauraunt &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.iconUrl, iconUrl) ||
                const DeepCollectionEquality().equals(other.iconUrl, iconUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(iconUrl);

  @JsonKey(ignore: true)
  @override
  _$RestaurauntCopyWith<_Restauraunt> get copyWith =>
      __$RestaurauntCopyWithImpl<_Restauraunt>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RestaurauntToJson(this);
  }
}

abstract class _Restauraunt extends Restauraunt {
  factory _Restauraunt(
      {required String name,
      required String id,
      required String address,
      required double rating,
      required String iconUrl}) = _$_Restauraunt;
  _Restauraunt._() : super._();

  factory _Restauraunt.fromJson(Map<String, dynamic> json) =
      _$_Restauraunt.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get address => throw _privateConstructorUsedError;
  @override
  double get rating => throw _privateConstructorUsedError;
  @override
  String get iconUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RestaurauntCopyWith<_Restauraunt> get copyWith =>
      throw _privateConstructorUsedError;
}
