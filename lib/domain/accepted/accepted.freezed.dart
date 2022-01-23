// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'accepted.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Accepted _$AcceptedFromJson(Map<String, dynamic> json) {
  return _Accepted.fromJson(json);
}

/// @nodoc
class _$AcceptedTearOff {
  const _$AcceptedTearOff();

  _Accepted call(
      {required List<String> accepted, required Restauraunt restaurant}) {
    return _Accepted(
      accepted: accepted,
      restaurant: restaurant,
    );
  }

  Accepted fromJson(Map<String, Object> json) {
    return Accepted.fromJson(json);
  }
}

/// @nodoc
const $Accepted = _$AcceptedTearOff();

/// @nodoc
mixin _$Accepted {
  /// ids of members that accepted this one
  List<String> get accepted => throw _privateConstructorUsedError;
  Restauraunt get restaurant => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AcceptedCopyWith<Accepted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcceptedCopyWith<$Res> {
  factory $AcceptedCopyWith(Accepted value, $Res Function(Accepted) then) =
      _$AcceptedCopyWithImpl<$Res>;
  $Res call({List<String> accepted, Restauraunt restaurant});

  $RestaurauntCopyWith<$Res> get restaurant;
}

/// @nodoc
class _$AcceptedCopyWithImpl<$Res> implements $AcceptedCopyWith<$Res> {
  _$AcceptedCopyWithImpl(this._value, this._then);

  final Accepted _value;
  // ignore: unused_field
  final $Res Function(Accepted) _then;

  @override
  $Res call({
    Object? accepted = freezed,
    Object? restaurant = freezed,
  }) {
    return _then(_value.copyWith(
      accepted: accepted == freezed
          ? _value.accepted
          : accepted // ignore: cast_nullable_to_non_nullable
              as List<String>,
      restaurant: restaurant == freezed
          ? _value.restaurant
          : restaurant // ignore: cast_nullable_to_non_nullable
              as Restauraunt,
    ));
  }

  @override
  $RestaurauntCopyWith<$Res> get restaurant {
    return $RestaurauntCopyWith<$Res>(_value.restaurant, (value) {
      return _then(_value.copyWith(restaurant: value));
    });
  }
}

/// @nodoc
abstract class _$AcceptedCopyWith<$Res> implements $AcceptedCopyWith<$Res> {
  factory _$AcceptedCopyWith(_Accepted value, $Res Function(_Accepted) then) =
      __$AcceptedCopyWithImpl<$Res>;
  @override
  $Res call({List<String> accepted, Restauraunt restaurant});

  @override
  $RestaurauntCopyWith<$Res> get restaurant;
}

/// @nodoc
class __$AcceptedCopyWithImpl<$Res> extends _$AcceptedCopyWithImpl<$Res>
    implements _$AcceptedCopyWith<$Res> {
  __$AcceptedCopyWithImpl(_Accepted _value, $Res Function(_Accepted) _then)
      : super(_value, (v) => _then(v as _Accepted));

  @override
  _Accepted get _value => super._value as _Accepted;

  @override
  $Res call({
    Object? accepted = freezed,
    Object? restaurant = freezed,
  }) {
    return _then(_Accepted(
      accepted: accepted == freezed
          ? _value.accepted
          : accepted // ignore: cast_nullable_to_non_nullable
              as List<String>,
      restaurant: restaurant == freezed
          ? _value.restaurant
          : restaurant // ignore: cast_nullable_to_non_nullable
              as Restauraunt,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Accepted implements _Accepted {
  _$_Accepted({required this.accepted, required this.restaurant});

  factory _$_Accepted.fromJson(Map<String, dynamic> json) =>
      _$_$_AcceptedFromJson(json);

  @override

  /// ids of members that accepted this one
  final List<String> accepted;
  @override
  final Restauraunt restaurant;

  @override
  String toString() {
    return 'Accepted(accepted: $accepted, restaurant: $restaurant)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Accepted &&
            (identical(other.accepted, accepted) ||
                const DeepCollectionEquality()
                    .equals(other.accepted, accepted)) &&
            (identical(other.restaurant, restaurant) ||
                const DeepCollectionEquality()
                    .equals(other.restaurant, restaurant)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(accepted) ^
      const DeepCollectionEquality().hash(restaurant);

  @JsonKey(ignore: true)
  @override
  _$AcceptedCopyWith<_Accepted> get copyWith =>
      __$AcceptedCopyWithImpl<_Accepted>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AcceptedToJson(this);
  }
}

abstract class _Accepted implements Accepted {
  factory _Accepted(
      {required List<String> accepted,
      required Restauraunt restaurant}) = _$_Accepted;

  factory _Accepted.fromJson(Map<String, dynamic> json) = _$_Accepted.fromJson;

  @override

  /// ids of members that accepted this one
  List<String> get accepted => throw _privateConstructorUsedError;
  @override
  Restauraunt get restaurant => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AcceptedCopyWith<_Accepted> get copyWith =>
      throw _privateConstructorUsedError;
}
