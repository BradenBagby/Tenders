import 'dart:async';
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      final Uri uri = Uri.dataFromString(href!);
      handleLink(uri);
      return;
    }

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      handleLink(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink.listen(
        (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;
      if (deepLink != null) {
        handleLink(deepLink);
      }
    }, onError: (dynamic e) async {
      log("error in link $e");
    });
  }

  static Future<void> handleLink(Uri link) async {
    log("handle link: $link");
    if (link.path.startsWith("/room")) {
      final roomId = link.path.replaceAll('/room/', '');
      await GetIt.I<RoomAuthCubit>().joinRoom(roomId).then((value) {
        if (!value) {
          final context = RootRouteController.key.currentContext!;
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Failed to join room"),
                content: Text("If this problem persists, contact support."),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Okay"),
                  )
                ],
              );
            },
          );
        }
      });
    }
  }

  static Future<String> createLink(String path,
      {bool preferShort = false}) async {
    if (cachedLinks.containsKey(path + preferShort.toString())) {
      return cachedLinks[path + preferShort.toString()]!;
    }
    String link;
    if (kIsWeb || !preferShort) {
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
        iosParameters: IOSParameters(
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
      final shortDynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(parameters);
      final Uri shortUrl = shortDynamicLink.shortUrl;
      link = shortUrl.toString();
    }
    cachedLinks[path + preferShort.toString()] = link;
    return link;
  }
}
