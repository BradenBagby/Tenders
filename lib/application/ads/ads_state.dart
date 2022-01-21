part of 'ads_cubit.dart';

@freezed
class AdsState with _$AdsState {
  const factory AdsState(
      {@Default(null) InterstitialAd? ad,

      /// how many times ad failed to laod
      @Default(0) int failedTimes}) = _AdsState;
  const AdsState._();
}
