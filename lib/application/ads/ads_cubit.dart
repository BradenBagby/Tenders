import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tenders/core/utility/environment.dart';

part 'ads_state.dart';
part 'ads_cubit.freezed.dart';

class AdsCubit extends Cubit<AdsState> {
  // TODO:
  String get adId => kDebugMode
      ? 'ca-app-pub-3940256099942544/4411468910'
      : (Platform.isIOS
          ? Environment.iosAdUnit
          : (Platform.isAndroid ? Environment.androidAdUnit : ''));

  AdsCubit() : super(AdsState()) {
    load();
  }

  Future<void> show() async {
    if (kIsWeb) return;
    if (state.ad == null) {
      if (state.failedTimes >= 4) return;
      await Future.delayed(const Duration(seconds: 1));
      if (state.ad == null) return;
    }
    if (state.ad != null) {
      state.ad!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
          print('%ad onAdShowedFullScreenContent.');
          emit(state.copyWith(ad: null));
          load();
        },
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
        },
        onAdImpression: (InterstitialAd ad) =>
            print('$ad impression occurred.'),
      );
      await state.ad!.show();
    }
  }

  Future<void> load() async {
    InterstitialAd.load(
        adUnitId: adId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            emit(state.copyWith(ad: ad, failedTimes: 0));
          },
          onAdFailedToLoad: (LoadAdError error) {
            emit(state.copyWith(failedTimes: state.failedTimes + 1));
            if (state.failedTimes < 4) {
              print("Failed to load ad, tyring again: ${state.failedTimes}");
              Future.delayed(const Duration(seconds: 2)).then((d) {
                load();
              });
            }
          },
        ));
  }
}
