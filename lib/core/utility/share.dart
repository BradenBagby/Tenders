import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'dart:developer' as dev;
import 'dart:ui' as ui;

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

  static Future<bool> shareWidget({required GlobalKey key}) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path + "/Soulmate.png";
      final file = File(tempPath);
      file.writeAsBytesSync(pngBytes);
      return await FlutterShare.shareFile(
            title: 'Found our Soulmate',
            filePath: file.path,
            fileType: "image/png",
          ) ??
          false;
    } catch (er) {
      dev.log("Failed to share: $er");
      return false;
    }
  }
}
