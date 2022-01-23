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

  _RoomAuthState call({RoomCubit? currentRoomCubit = null, Member? me = null}) {
    return _RoomAuthState(
      currentRoomCubit: currentRoomCubit,
      me: me,
    );
  }
}

/// @nodoc
const $RoomAuthState = _$RoomAuthStateTearOff();

/// @nodoc
mixin _$RoomAuthState {
  /// current room you are in (if any)
  RoomCubit? get currentRoomCubit => throw _privateConstructorUsedError;

  /// my memer info
  Member? get me => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoomAuthStateCopyWith<RoomAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomAuthStateCopyWith<$Res> {
  factory $RoomAuthStateCopyWith(
          RoomAuthState value, $Res Function(RoomAuthState) then) =
      _$RoomAuthStateCopyWithImpl<$Res>;
  $Res call({RoomCubit? currentRoomCubit, Member? me});

  $MemberCopyWith<$Res>? get me;
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
    Object? currentRoomCubit = freezed,
    Object? me = freezed,
  }) {
    return _then(_value.copyWith(
      currentRoomCubit: currentRoomCubit == freezed
          ? _value.currentRoomCubit
          : currentRoomCubit // ignore: cast_nullable_to_non_nullable
              as RoomCubit?,
      me: me == freezed
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as Member?,
    ));
  }

  @override
  $MemberCopyWith<$Res>? get me {
    if (_value.me == null) {
      return null;
    }

    return $MemberCopyWith<$Res>(_value.me!, (value) {
      return _then(_value.copyWith(me: value));
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
  $Res call({RoomCubit? currentRoomCubit, Member? me});

  @override
  $MemberCopyWith<$Res>? get me;
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
    Object? currentRoomCubit = freezed,
    Object? me = freezed,
  }) {
    return _then(_RoomAuthState(
      currentRoomCubit: currentRoomCubit == freezed
          ? _value.currentRoomCubit
          : currentRoomCubit // ignore: cast_nullable_to_non_nullable
              as RoomCubit?,
      me: me == freezed
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as Member?,
    ));
  }
}

/// @nodoc
class _$_RoomAuthState extends _RoomAuthState {
  const _$_RoomAuthState({this.currentRoomCubit = null, this.me = null})
      : super._();

  @JsonKey(defaultValue: null)
  @override

  /// current room you are in (if any)
  final RoomCubit? currentRoomCubit;
  @JsonKey(defaultValue: null)
  @override

  /// my memer info
  final Member? me;

  @override
  String toString() {
    return 'RoomAuthState(currentRoomCubit: $currentRoomCubit, me: $me)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoomAuthState &&
            (identical(other.currentRoomCubit, currentRoomCubit) ||
                const DeepCollectionEquality()
                    .equals(other.currentRoomCubit, currentRoomCubit)) &&
            (identical(other.me, me) ||
                const DeepCollectionEquality().equals(other.me, me)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currentRoomCubit) ^
      const DeepCollectionEquality().hash(me);

  @JsonKey(ignore: true)
  @override
  _$RoomAuthStateCopyWith<_RoomAuthState> get copyWith =>
      __$RoomAuthStateCopyWithImpl<_RoomAuthState>(this, _$identity);
}

abstract class _RoomAuthState extends RoomAuthState {
  const factory _RoomAuthState({RoomCubit? currentRoomCubit, Member? me}) =
      _$_RoomAuthState;
  const _RoomAuthState._() : super._();

  @override

  /// current room you are in (if any)
  RoomCubit? get currentRoomCubit => throw _privateConstructorUsedError;
  @override

  /// my memer info
  Member? get me => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RoomAuthStateCopyWith<_RoomAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}
