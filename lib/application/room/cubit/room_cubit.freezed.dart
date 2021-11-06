// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'room_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RoomStateTearOff {
  const _$RoomStateTearOff();

  _RoomState call(
      {required Room room,
      required Member me,
      required List<Member> members,
      LocationData? currentLocation = null,
      required List<Restauraunt> restauraunts,
      int currentViewIndex = 0,
      bool closed = false}) {
    return _RoomState(
      room: room,
      me: me,
      members: members,
      currentLocation: currentLocation,
      restauraunts: restauraunts,
      currentViewIndex: currentViewIndex,
      closed: closed,
    );
  }
}

/// @nodoc
const $RoomState = _$RoomStateTearOff();

/// @nodoc
mixin _$RoomState {
  Room get room => throw _privateConstructorUsedError;
  Member get me => throw _privateConstructorUsedError;
  List<Member> get members => throw _privateConstructorUsedError;
  LocationData? get currentLocation => throw _privateConstructorUsedError;
  List<Restauraunt> get restauraunts => throw _privateConstructorUsedError;
  int get currentViewIndex =>
      throw _privateConstructorUsedError; // if this room was closed
  bool get closed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoomStateCopyWith<RoomState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomStateCopyWith<$Res> {
  factory $RoomStateCopyWith(RoomState value, $Res Function(RoomState) then) =
      _$RoomStateCopyWithImpl<$Res>;
  $Res call(
      {Room room,
      Member me,
      List<Member> members,
      LocationData? currentLocation,
      List<Restauraunt> restauraunts,
      int currentViewIndex,
      bool closed});

  $RoomCopyWith<$Res> get room;
  $MemberCopyWith<$Res> get me;
}

/// @nodoc
class _$RoomStateCopyWithImpl<$Res> implements $RoomStateCopyWith<$Res> {
  _$RoomStateCopyWithImpl(this._value, this._then);

  final RoomState _value;
  // ignore: unused_field
  final $Res Function(RoomState) _then;

  @override
  $Res call({
    Object? room = freezed,
    Object? me = freezed,
    Object? members = freezed,
    Object? currentLocation = freezed,
    Object? restauraunts = freezed,
    Object? currentViewIndex = freezed,
    Object? closed = freezed,
  }) {
    return _then(_value.copyWith(
      room: room == freezed
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as Room,
      me: me == freezed
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as Member,
      members: members == freezed
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Member>,
      currentLocation: currentLocation == freezed
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LocationData?,
      restauraunts: restauraunts == freezed
          ? _value.restauraunts
          : restauraunts // ignore: cast_nullable_to_non_nullable
              as List<Restauraunt>,
      currentViewIndex: currentViewIndex == freezed
          ? _value.currentViewIndex
          : currentViewIndex // ignore: cast_nullable_to_non_nullable
              as int,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $RoomCopyWith<$Res> get room {
    return $RoomCopyWith<$Res>(_value.room, (value) {
      return _then(_value.copyWith(room: value));
    });
  }

  @override
  $MemberCopyWith<$Res> get me {
    return $MemberCopyWith<$Res>(_value.me, (value) {
      return _then(_value.copyWith(me: value));
    });
  }
}

/// @nodoc
abstract class _$RoomStateCopyWith<$Res> implements $RoomStateCopyWith<$Res> {
  factory _$RoomStateCopyWith(
          _RoomState value, $Res Function(_RoomState) then) =
      __$RoomStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Room room,
      Member me,
      List<Member> members,
      LocationData? currentLocation,
      List<Restauraunt> restauraunts,
      int currentViewIndex,
      bool closed});

  @override
  $RoomCopyWith<$Res> get room;
  @override
  $MemberCopyWith<$Res> get me;
}

/// @nodoc
class __$RoomStateCopyWithImpl<$Res> extends _$RoomStateCopyWithImpl<$Res>
    implements _$RoomStateCopyWith<$Res> {
  __$RoomStateCopyWithImpl(_RoomState _value, $Res Function(_RoomState) _then)
      : super(_value, (v) => _then(v as _RoomState));

  @override
  _RoomState get _value => super._value as _RoomState;

  @override
  $Res call({
    Object? room = freezed,
    Object? me = freezed,
    Object? members = freezed,
    Object? currentLocation = freezed,
    Object? restauraunts = freezed,
    Object? currentViewIndex = freezed,
    Object? closed = freezed,
  }) {
    return _then(_RoomState(
      room: room == freezed
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as Room,
      me: me == freezed
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as Member,
      members: members == freezed
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Member>,
      currentLocation: currentLocation == freezed
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LocationData?,
      restauraunts: restauraunts == freezed
          ? _value.restauraunts
          : restauraunts // ignore: cast_nullable_to_non_nullable
              as List<Restauraunt>,
      currentViewIndex: currentViewIndex == freezed
          ? _value.currentViewIndex
          : currentViewIndex // ignore: cast_nullable_to_non_nullable
              as int,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
class _$_RoomState extends _RoomState {
  const _$_RoomState(
      {required this.room,
      required this.me,
      required this.members,
      this.currentLocation = null,
      required this.restauraunts,
      this.currentViewIndex = 0,
      this.closed = false})
      : super._();

  @override
  final Room room;
  @override
  final Member me;
  @override
  final List<Member> members;
  @JsonKey(defaultValue: null)
  @override
  final LocationData? currentLocation;
  @override
  final List<Restauraunt> restauraunts;
  @JsonKey(defaultValue: 0)
  @override
  final int currentViewIndex;
  @JsonKey(defaultValue: false)
  @override // if this room was closed
  final bool closed;

  @override
  String toString() {
    return 'RoomState(room: $room, me: $me, members: $members, currentLocation: $currentLocation, restauraunts: $restauraunts, currentViewIndex: $currentViewIndex, closed: $closed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoomState &&
            (identical(other.room, room) ||
                const DeepCollectionEquality().equals(other.room, room)) &&
            (identical(other.me, me) ||
                const DeepCollectionEquality().equals(other.me, me)) &&
            (identical(other.members, members) ||
                const DeepCollectionEquality()
                    .equals(other.members, members)) &&
            (identical(other.currentLocation, currentLocation) ||
                const DeepCollectionEquality()
                    .equals(other.currentLocation, currentLocation)) &&
            (identical(other.restauraunts, restauraunts) ||
                const DeepCollectionEquality()
                    .equals(other.restauraunts, restauraunts)) &&
            (identical(other.currentViewIndex, currentViewIndex) ||
                const DeepCollectionEquality()
                    .equals(other.currentViewIndex, currentViewIndex)) &&
            (identical(other.closed, closed) ||
                const DeepCollectionEquality().equals(other.closed, closed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(room) ^
      const DeepCollectionEquality().hash(me) ^
      const DeepCollectionEquality().hash(members) ^
      const DeepCollectionEquality().hash(currentLocation) ^
      const DeepCollectionEquality().hash(restauraunts) ^
      const DeepCollectionEquality().hash(currentViewIndex) ^
      const DeepCollectionEquality().hash(closed);

  @JsonKey(ignore: true)
  @override
  _$RoomStateCopyWith<_RoomState> get copyWith =>
      __$RoomStateCopyWithImpl<_RoomState>(this, _$identity);
}

abstract class _RoomState extends RoomState {
  const factory _RoomState(
      {required Room room,
      required Member me,
      required List<Member> members,
      LocationData? currentLocation,
      required List<Restauraunt> restauraunts,
      int currentViewIndex,
      bool closed}) = _$_RoomState;
  const _RoomState._() : super._();

  @override
  Room get room => throw _privateConstructorUsedError;
  @override
  Member get me => throw _privateConstructorUsedError;
  @override
  List<Member> get members => throw _privateConstructorUsedError;
  @override
  LocationData? get currentLocation => throw _privateConstructorUsedError;
  @override
  List<Restauraunt> get restauraunts => throw _privateConstructorUsedError;
  @override
  int get currentViewIndex => throw _privateConstructorUsedError;
  @override // if this room was closed
  bool get closed => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RoomStateCopyWith<_RoomState> get copyWith =>
      throw _privateConstructorUsedError;
}
