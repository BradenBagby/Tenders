import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:tenders/core/utility/route_controllers.dart';

class Share {
  static Future<bool> shareInvite(
      {required String link, required String message}) async {
    if (kIsWeb) {
      Clipboard.setData(ClipboardData(text: "$message $link"));
      ScaffoldMessenger.of(RootRouteController.key.currentContext!)
          .showSnackBar(SnackBar(content: Text("Invite copied to clipboard")));
      return true;
    } else {
      return await FlutterShare.share(
            title: 'Tenders app!',
            text: message,
            linkUrl: link,
          ) ??
          false;
    }
  }
}
