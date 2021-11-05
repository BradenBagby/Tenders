import 'dart:async';
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';

class DynamicLinks {
  const DynamicLinks._();

  static final _authLinkStreamController = StreamController<Uri>.broadcast();
  static Stream<Uri> get authLinkStream => _authLinkStreamController.stream;

  /// get initial dynamic link and begin listening for more
  static Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      _handleLink(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;
      if (deepLink != null) {
        _handleLink(deepLink);
      }
    }, onError: (OnLinkErrorException e) async {
      log("error in link $e");
    });
  }

  static void _handleLink(Uri link) {
    log("handle link: $link");
  }

  static Future<String> createLink(String path) async {
    //TODO:
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://tenders.page.link',
      link: Uri.parse(
          'https://tenders.page.link${path.isNotEmpty ? "/$path" : ""}'),
      androidParameters: AndroidParameters(
        packageName: 'com.bradenbagby.tenders',
        // minimumVersion: 125,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.bradenbagby.tenders',
        // minimumVersion: '1.0.1',
        // appStoreId: '123456789',
      ),
      /* 
  googleAnalyticsParameters: GoogleAnalyticsParameters(
      campaign: 'sign-in',
      medium: 'social',
      source: 'orkut',
  ),
  itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
    providerToken: '123456',
    campaignToken: 'sign-in',
  ),
  socialMetaTagParameters:  SocialMetaTagParameters(
    title: 'Example of a Dynamic Link',
    description: 'This link works whether app is installed or not!',
  ),*/
    );
    final shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    return shortUrl.toString();
//final Uri dynamicUrl = await parameters.buildUrl();
  }
}
