// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'room_auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RoomAuthStateTearOff {
  const _$RoomAuthStateTearOff();

  _RoomAuthState call({Room? currentRoom = null, Member? myMember = null}) {
    return _RoomAuthState(
      currentRoom: currentRoom,
      myMember: myMember,
    );
  }
}

/// @nodoc
const $RoomAuthState = _$RoomAuthStateTearOff();

/// @nodoc
mixin _$RoomAuthState {
  /// current room you are in (if any)
  Room? get currentRoom => throw _privateConstructorUsedError;

  /// your member reference while in the room (if any)
  Member? get myMember => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoomAuthStateCopyWith<RoomAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomAuthStateCopyWith<$Res> {
  factory $RoomAuthStateCopyWith(
          RoomAuthState value, $Res Function(RoomAuthState) then) =
      _$RoomAuthStateCopyWithImpl<$Res>;
  $Res call({Room? currentRoom, Member? myMember});

  $RoomCopyWith<$Res>? get currentRoom;
  $MemberCopyWith<$Res>? get myMember;
}

/// @nodoc
class _$RoomAuthStateCopyWithImpl<$Res>
    implements $RoomAuthStateCopyWith<$Res> {
  _$RoomAuthStateCopyWithImpl(this._value, this._then);

  final RoomAuthState _value;
  // ignore: unused_field
  final $Res Function(RoomAuthState) _then;

  @override
  $Res call({
    Object? currentRoom = freezed,
    Object? myMember = freezed,
  }) {
    return _then(_value.copyWith(
      currentRoom: currentRoom == freezed
          ? _value.currentRoom
          : currentRoom // ignore: cast_nullable_to_non_nullable
              as Room?,
      myMember: myMember == freezed
          ? _value.myMember
          : myMember // ignore: cast_nullable_to_non_nullable
              as Member?,
    ));
  }

  @override
  $RoomCopyWith<$Res>? get currentRoom {
    if (_value.currentRoom == null) {
      return null;
    }

    return $RoomCopyWith<$Res>(_value.currentRoom!, (value) {
      return _then(_value.copyWith(currentRoom: value));
    });
  }

  @override
  $MemberCopyWith<$Res>? get myMember {
    if (_value.myMember == null) {
      return null;
    }

    return $MemberCopyWith<$Res>(_value.myMember!, (value) {
      return _then(_value.copyWith(myMember: value));
    });
  }
}

/// @nodoc
abstract class _$RoomAuthStateCopyWith<$Res>
    implements $RoomAuthStateCopyWith<$Res> {
  factory _$RoomAuthStateCopyWith(
          _RoomAuthState value, $Res Function(_RoomAuthState) then) =
      __$RoomAuthStateCopyWithImpl<$Res>;
  @override
  $Res call({Room? currentRoom, Member? myMember});

  @override
  $RoomCopyWith<$Res>? get currentRoom;
  @override
  $MemberCopyWith<$Res>? get myMember;
}

/// @nodoc
class __$RoomAuthStateCopyWithImpl<$Res>
    extends _$RoomAuthStateCopyWithImpl<$Res>
    implements _$RoomAuthStateCopyWith<$Res> {
  __$RoomAuthStateCopyWithImpl(
      _RoomAuthState _value, $Res Function(_RoomAuthState) _then)
      : super(_value, (v) => _then(v as _RoomAuthState));

  @override
  _RoomAuthState get _value => super._value as _RoomAuthState;

  @override
  $Res call({
    Object? currentRoom = freezed,
    Object? myMember = freezed,
  }) {
    return _then(_RoomAuthState(
      currentRoom: currentRoom == freezed
          ? _value.currentRoom
          : currentRoom // ignore: cast_nullable_to_non_nullable
              as Room?,
      myMember: myMember == freezed
          ? _value.myMember
          : myMember // ignore: cast_nullable_to_non_nullable
              as Member?,
    ));
  }
}

/// @nodoc
class _$_RoomAuthState implements _RoomAuthState {
  const _$_RoomAuthState({this.currentRoom = null, this.myMember = null});

  @JsonKey(defaultValue: null)
  @override

  /// current room you are in (if any)
  final Room? currentRoom;
  @JsonKey(defaultValue: null)
  @override

  /// your member reference while in the room (if any)
  final Member? myMember;

  @override
  String toString() {
    return 'RoomAuthState(currentRoom: $currentRoom, myMember: $myMember)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoomAuthState &&
            (identical(other.currentRoom, currentRoom) ||
                const DeepCollectionEquality()
                    .equals(other.currentRoom, currentRoom)) &&
            (identical(other.myMember, myMember) ||
                const DeepCollectionEquality()
                    .equals(other.myMember, myMember)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currentRoom) ^
      const DeepCollectionEquality().hash(myMember);

  @JsonKey(ignore: true)
  @override
  _$RoomAuthStateCopyWith<_RoomAuthState> get copyWith =>
      __$RoomAuthStateCopyWithImpl<_RoomAuthState>(this, _$identity);
}

abstract class _RoomAuthState implements RoomAuthState {
  const factory _RoomAuthState({Room? currentRoom, Member? myMember}) =
      _$_RoomAuthState;

  @override

  /// current room you are in (if any)
  Room? get currentRoom => throw _privateConstructorUsedError;
  @override

  /// your member reference while in the room (if any)
  Member? get myMember => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RoomAuthStateCopyWith<_RoomAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}
