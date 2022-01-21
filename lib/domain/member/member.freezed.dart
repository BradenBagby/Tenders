// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Member _$MemberFromJson(Map<String, dynamic> json) {
  return _Member.fromJson(json);
}

/// @nodoc
class _$MemberTearOff {
  const _$MemberTearOff();

  _Member call(
      {required DateTime joinedAt,
      required String id,
      bool disconnected = false}) {
    return _Member(
      joinedAt: joinedAt,
      id: id,
      disconnected: disconnected,
    );
  }

  Member fromJson(Map<String, Object> json) {
    return Member.fromJson(json);
  }
}

/// @nodoc
const $Member = _$MemberTearOff();

/// @nodoc
mixin _$Member {
  DateTime get joinedAt => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  bool get disconnected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemberCopyWith<Member> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberCopyWith<$Res> {
  factory $MemberCopyWith(Member value, $Res Function(Member) then) =
      _$MemberCopyWithImpl<$Res>;
  $Res call({DateTime joinedAt, String id, bool disconnected});
}

/// @nodoc
class _$MemberCopyWithImpl<$Res> implements $MemberCopyWith<$Res> {
  _$MemberCopyWithImpl(this._value, this._then);

  final Member _value;
  // ignore: unused_field
  final $Res Function(Member) _then;

  @override
  $Res call({
    Object? joinedAt = freezed,
    Object? id = freezed,
    Object? disconnected = freezed,
  }) {
    return _then(_value.copyWith(
      joinedAt: joinedAt == freezed
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      disconnected: disconnected == freezed
          ? _value.disconnected
          : disconnected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$MemberCopyWith<$Res> implements $MemberCopyWith<$Res> {
  factory _$MemberCopyWith(_Member value, $Res Function(_Member) then) =
      __$MemberCopyWithImpl<$Res>;
  @override
  $Res call({DateTime joinedAt, String id, bool disconnected});
}

/// @nodoc
class __$MemberCopyWithImpl<$Res> extends _$MemberCopyWithImpl<$Res>
    implements _$MemberCopyWith<$Res> {
  __$MemberCopyWithImpl(_Member _value, $Res Function(_Member) _then)
      : super(_value, (v) => _then(v as _Member));

  @override
  _Member get _value => super._value as _Member;

  @override
  $Res call({
    Object? joinedAt = freezed,
    Object? id = freezed,
    Object? disconnected = freezed,
  }) {
    return _then(_Member(
      joinedAt: joinedAt == freezed
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      disconnected: disconnected == freezed
          ? _value.disconnected
          : disconnected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Member implements _Member {
  _$_Member(
      {required this.joinedAt, required this.id, this.disconnected = false});

  factory _$_Member.fromJson(Map<String, dynamic> json) =>
      _$_$_MemberFromJson(json);

  @override
  final DateTime joinedAt;
  @override
  final String id;
  @JsonKey(defaultValue: false)
  @override
  final bool disconnected;

  @override
  String toString() {
    return 'Member(joinedAt: $joinedAt, id: $id, disconnected: $disconnected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Member &&
            (identical(other.joinedAt, joinedAt) ||
                const DeepCollectionEquality()
                    .equals(other.joinedAt, joinedAt)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.disconnected, disconnected) ||
                const DeepCollectionEquality()
                    .equals(other.disconnected, disconnected)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(joinedAt) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(disconnected);

  @JsonKey(ignore: true)
  @override
  _$MemberCopyWith<_Member> get copyWith =>
      __$MemberCopyWithImpl<_Member>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MemberToJson(this);
  }
}

abstract class _Member implements Member {
  factory _Member(
      {required DateTime joinedAt,
      required String id,
      bool disconnected}) = _$_Member;

  factory _Member.fromJson(Map<String, dynamic> json) = _$_Member.fromJson;

  @override
  DateTime get joinedAt => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  bool get disconnected => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MemberCopyWith<_Member> get copyWith => throw _privateConstructorUsedError;
}
