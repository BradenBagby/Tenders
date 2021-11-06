// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'room_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomSettings _$RoomSettingsFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
class _$RoomSettingsTearOff {
  const _$RoomSettingsTearOff();

  _Room call(
      {required int radius, required PlaceType type, required bool openNow}) {
    return _Room(
      radius: radius,
      type: type,
      openNow: openNow,
    );
  }

  RoomSettings fromJson(Map<String, Object> json) {
    return RoomSettings.fromJson(json);
  }
}

/// @nodoc
const $RoomSettings = _$RoomSettingsTearOff();

/// @nodoc
mixin _$RoomSettings {
  int get radius => throw _privateConstructorUsedError;
  PlaceType get type => throw _privateConstructorUsedError;
  bool get openNow => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomSettingsCopyWith<RoomSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomSettingsCopyWith<$Res> {
  factory $RoomSettingsCopyWith(
          RoomSettings value, $Res Function(RoomSettings) then) =
      _$RoomSettingsCopyWithImpl<$Res>;
  $Res call({int radius, PlaceType type, bool openNow});
}

/// @nodoc
class _$RoomSettingsCopyWithImpl<$Res> implements $RoomSettingsCopyWith<$Res> {
  _$RoomSettingsCopyWithImpl(this._value, this._then);

  final RoomSettings _value;
  // ignore: unused_field
  final $Res Function(RoomSettings) _then;

  @override
  $Res call({
    Object? radius = freezed,
    Object? type = freezed,
    Object? openNow = freezed,
  }) {
    return _then(_value.copyWith(
      radius: radius == freezed
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PlaceType,
      openNow: openNow == freezed
          ? _value.openNow
          : openNow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$RoomCopyWith<$Res> implements $RoomSettingsCopyWith<$Res> {
  factory _$RoomCopyWith(_Room value, $Res Function(_Room) then) =
      __$RoomCopyWithImpl<$Res>;
  @override
  $Res call({int radius, PlaceType type, bool openNow});
}

/// @nodoc
class __$RoomCopyWithImpl<$Res> extends _$RoomSettingsCopyWithImpl<$Res>
    implements _$RoomCopyWith<$Res> {
  __$RoomCopyWithImpl(_Room _value, $Res Function(_Room) _then)
      : super(_value, (v) => _then(v as _Room));

  @override
  _Room get _value => super._value as _Room;

  @override
  $Res call({
    Object? radius = freezed,
    Object? type = freezed,
    Object? openNow = freezed,
  }) {
    return _then(_Room(
      radius: radius == freezed
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PlaceType,
      openNow: openNow == freezed
          ? _value.openNow
          : openNow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Room implements _Room {
  _$_Room({required this.radius, required this.type, required this.openNow});

  factory _$_Room.fromJson(Map<String, dynamic> json) =>
      _$_$_RoomFromJson(json);

  @override
  final int radius;
  @override
  final PlaceType type;
  @override
  final bool openNow;

  @override
  String toString() {
    return 'RoomSettings(radius: $radius, type: $type, openNow: $openNow)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Room &&
            (identical(other.radius, radius) ||
                const DeepCollectionEquality().equals(other.radius, radius)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.openNow, openNow) ||
                const DeepCollectionEquality().equals(other.openNow, openNow)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(radius) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(openNow);

  @JsonKey(ignore: true)
  @override
  _$RoomCopyWith<_Room> get copyWith =>
      __$RoomCopyWithImpl<_Room>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RoomToJson(this);
  }
}

abstract class _Room implements RoomSettings {
  factory _Room(
      {required int radius,
      required PlaceType type,
      required bool openNow}) = _$_Room;

  factory _Room.fromJson(Map<String, dynamic> json) = _$_Room.fromJson;

  @override
  int get radius => throw _privateConstructorUsedError;
  @override
  PlaceType get type => throw _privateConstructorUsedError;
  @override
  bool get openNow => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RoomCopyWith<_Room> get copyWith => throw _privateConstructorUsedError;
}
