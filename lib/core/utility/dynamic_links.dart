import 'dart:async';
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:window_location_href/window_location_href.dart';

class DynamicLinks {
  const DynamicLinks._();

  /// cached already created links
  static Map<String, String> cachedLinks = {};

  static final _authLinkStreamController = StreamController<Uri>.broadcast();
  static Stream<Uri> get authLinkStream => _authLinkStreamController.stream;

  /// get initial dynamic link and begin listening for more
  static Future<void> initDynamicLinks() async {
    if (kIsWeb) {
      final Uri uri = Uri.dataFromString(getHref()!);
      _handleLink(uri);
      return;
    }

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
    if (link.path.startsWith("/room")) {
      final roomId = link.path.replaceAll('/room', '');
      GetIt.I<RoomAuthCubit>().joinRoom(roomId);
    }
  }

  static Future<String> createLink(String path) async {
    if (cachedLinks.containsKey(path)) {
      return cachedLinks[path]!;
    }
    String link;
    if (kIsWeb) {
      link =
          '${'https://tenders.page.link'}/?link=${Uri.parse('https://tenders.page.link${path.isNotEmpty ? "/$path" : ""}')}&apn=${'com.bradenbagby.tenders'}&ibi=${'com.bradenbagby.tenders'}';
    } else {
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
      link = shortUrl.toString();
    }
    cachedLinks[path] = link;
    return link;
  }
}
