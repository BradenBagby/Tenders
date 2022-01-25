// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
class _$RoomTearOff {
  const _$RoomTearOff();

  _Room call(
      {required String id,
      required DateTime createdAt,
      required RoomSettings settings,
      bool started = false,
      required double latitude,
      required double longitude,
      String? version = null}) {
    return _Room(
      id: id,
      createdAt: createdAt,
      settings: settings,
      started: started,
      latitude: latitude,
      longitude: longitude,
      version: version,
    );
  }

  Room fromJson(Map<String, Object> json) {
    return Room.fromJson(json);
  }
}

/// @nodoc
const $Room = _$RoomTearOff();

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  RoomSettings get settings => throw _privateConstructorUsedError;
  bool get started => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude =>
      throw _privateConstructorUsedError; //required String locationString,
  String? get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res>;
  $Res call(
      {String id,
      DateTime createdAt,
      RoomSettings settings,
      bool started,
      double latitude,
      double longitude,
      String? version});

  $RoomSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$RoomCopyWithImpl<$Res> implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  final Room _value;
  // ignore: unused_field
  final $Res Function(Room) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? settings = freezed,
    Object? started = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      settings: settings == freezed
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as RoomSettings,
      started: started == freezed
          ? _value.started
          : started // ignore: cast_nullable_to_non_nullable
              as bool,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $RoomSettingsCopyWith<$Res> get settings {
    return $RoomSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value));
    });
  }
}

/// @nodoc
abstract class _$RoomCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$RoomCopyWith(_Room value, $Res Function(_Room) then) =
      __$RoomCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      DateTime createdAt,
      RoomSettings settings,
      bool started,
      double latitude,
      double longitude,
      String? version});

  @override
  $RoomSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$RoomCopyWithImpl<$Res> extends _$RoomCopyWithImpl<$Res>
    implements _$RoomCopyWith<$Res> {
  __$RoomCopyWithImpl(_Room _value, $Res Function(_Room) _then)
      : super(_value, (v) => _then(v as _Room));

  @override
  _Room get _value => super._value as _Room;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? settings = freezed,
    Object? started = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? version = freezed,
  }) {
    return _then(_Room(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      settings: settings == freezed
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as RoomSettings,
      started: started == freezed
          ? _value.started
          : started // ignore: cast_nullable_to_non_nullable
              as bool,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

@JsonSerializable(explicitToJson: true)

/// @nodoc
class _$_Room implements _Room {
  _$_Room(
      {required this.id,
      required this.createdAt,
      required this.settings,
      this.started = false,
      required this.latitude,
      required this.longitude,
      this.version = null});

  factory _$_Room.fromJson(Map<String, dynamic> json) =>
      _$_$_RoomFromJson(json);

  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final RoomSettings settings;
  @JsonKey(defaultValue: false)
  @override
  final bool started;
  @override
  final double latitude;
  @override
  final double longitude;
  @JsonKey(defaultValue: null)
  @override //required String locationString,
  final String? version;

  @override
  String toString() {
    return 'Room(id: $id, createdAt: $createdAt, settings: $settings, started: $started, latitude: $latitude, longitude: $longitude, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Room &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.settings, settings) ||
                const DeepCollectionEquality()
                    .equals(other.settings, settings)) &&
            (identical(other.started, started) ||
                const DeepCollectionEquality()
                    .equals(other.started, started)) &&
            (identical(other.latitude, latitude) ||
                const DeepCollectionEquality()
                    .equals(other.latitude, latitude)) &&
            (identical(other.longitude, longitude) ||
                const DeepCollectionEquality()
                    .equals(other.longitude, longitude)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality().equals(other.version, version)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(settings) ^
      const DeepCollectionEquality().hash(started) ^
      const DeepCollectionEquality().hash(latitude) ^
      const DeepCollectionEquality().hash(longitude) ^
      const DeepCollectionEquality().hash(version);

  @JsonKey(ignore: true)
  @override
  _$RoomCopyWith<_Room> get copyWith =>
      __$RoomCopyWithImpl<_Room>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RoomToJson(this);
  }
}

abstract class _Room implements Room {
  factory _Room(
      {required String id,
      required DateTime createdAt,
      required RoomSettings settings,
      bool started,
      required double latitude,
      required double longitude,
      String? version}) = _$_Room;

  factory _Room.fromJson(Map<String, dynamic> json) = _$_Room.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  RoomSettings get settings => throw _privateConstructorUsedError;
  @override
  bool get started => throw _privateConstructorUsedError;
  @override
  double get latitude => throw _privateConstructorUsedError;
  @override
  double get longitude => throw _privateConstructorUsedError;
  @override //required String locationString,
  String? get version => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RoomCopyWith<_Room> get copyWith => throw _privateConstructorUsedError;
}
