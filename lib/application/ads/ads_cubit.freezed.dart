// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'ads_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AdsStateTearOff {
  const _$AdsStateTearOff();

  _AdsState call({InterstitialAd? ad = null, int failedTimes = 0}) {
    return _AdsState(
      ad: ad,
      failedTimes: failedTimes,
    );
  }
}

/// @nodoc
const $AdsState = _$AdsStateTearOff();

/// @nodoc
mixin _$AdsState {
  InterstitialAd? get ad => throw _privateConstructorUsedError;

  /// how many times ad failed to laod
  int get failedTimes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdsStateCopyWith<AdsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdsStateCopyWith<$Res> {
  factory $AdsStateCopyWith(AdsState value, $Res Function(AdsState) then) =
      _$AdsStateCopyWithImpl<$Res>;
  $Res call({InterstitialAd? ad, int failedTimes});
}

/// @nodoc
class _$AdsStateCopyWithImpl<$Res> implements $AdsStateCopyWith<$Res> {
  _$AdsStateCopyWithImpl(this._value, this._then);

  final AdsState _value;
  // ignore: unused_field
  final $Res Function(AdsState) _then;

  @override
  $Res call({
    Object? ad = freezed,
    Object? failedTimes = freezed,
  }) {
    return _then(_value.copyWith(
      ad: ad == freezed
          ? _value.ad
          : ad // ignore: cast_nullable_to_non_nullable
              as InterstitialAd?,
      failedTimes: failedTimes == freezed
          ? _value.failedTimes
          : failedTimes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$AdsStateCopyWith<$Res> implements $AdsStateCopyWith<$Res> {
  factory _$AdsStateCopyWith(_AdsState value, $Res Function(_AdsState) then) =
      __$AdsStateCopyWithImpl<$Res>;
  @override
  $Res call({InterstitialAd? ad, int failedTimes});
}

/// @nodoc
class __$AdsStateCopyWithImpl<$Res> extends _$AdsStateCopyWithImpl<$Res>
    implements _$AdsStateCopyWith<$Res> {
  __$AdsStateCopyWithImpl(_AdsState _value, $Res Function(_AdsState) _then)
      : super(_value, (v) => _then(v as _AdsState));

  @override
  _AdsState get _value => super._value as _AdsState;

  @override
  $Res call({
    Object? ad = freezed,
    Object? failedTimes = freezed,
  }) {
    return _then(_AdsState(
      ad: ad == freezed
          ? _value.ad
          : ad // ignore: cast_nullable_to_non_nullable
              as InterstitialAd?,
      failedTimes: failedTimes == freezed
          ? _value.failedTimes
          : failedTimes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
class _$_AdsState extends _AdsState with DiagnosticableTreeMixin {
  const _$_AdsState({this.ad = null, this.failedTimes = 0}) : super._();

  @JsonKey(defaultValue: null)
  @override
  final InterstitialAd? ad;
  @JsonKey(defaultValue: 0)
  @override

  /// how many times ad failed to laod
  final int failedTimes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AdsState(ad: $ad, failedTimes: $failedTimes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AdsState'))
      ..add(DiagnosticsProperty('ad', ad))
      ..add(DiagnosticsProperty('failedTimes', failedTimes));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AdsState &&
            (identical(other.ad, ad) ||
                const DeepCollectionEquality().equals(other.ad, ad)) &&
            (identical(other.failedTimes, failedTimes) ||
                const DeepCollectionEquality()
                    .equals(other.failedTimes, failedTimes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(ad) ^
      const DeepCollectionEquality().hash(failedTimes);

  @JsonKey(ignore: true)
  @override
  _$AdsStateCopyWith<_AdsState> get copyWith =>
      __$AdsStateCopyWithImpl<_AdsState>(this, _$identity);
}

abstract class _AdsState extends AdsState {
  const factory _AdsState({InterstitialAd? ad, int failedTimes}) = _$_AdsState;
  const _AdsState._() : super._();

  @override
  InterstitialAd? get ad => throw _privateConstructorUsedError;
  @override

  /// how many times ad failed to laod
  int get failedTimes => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AdsStateCopyWith<_AdsState> get copyWith =>
      throw _privateConstructorUsedError;
}
