import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Environment {
  const Environment._();

  static late Map<String, dynamic> _environment;

  /// load environment file
  static Future<void> init() async {
    final environmentString =
        await rootBundle.loadString("config/environment.json");
    _environment = (json.decode(environmentString) as Map<String, dynamic>);
  }

  /// getters
  static String get placesApiKey => _environment["places_api_key"] as String;
  static String get iosAdUnit => _environment["ios_ad"] as String;
  static String get androidAdUnit => _environment["android_ad"] as String;
  static bool get marketing =>
      (_environment["marketing"] as bool? ?? false) && kDebugMode;
  static bool get testRoomsInDebug =>
      (_environment["testRoomsInDebug"] as bool? ?? false) && kDebugMode;
  static bool get hideConfettiDebug =>
      _environment["hideConfettiDebug"] as bool? ?? false;
  static bool get useAdsInDebug =>
      _environment["useAdsInDebug"] as bool? ?? false;
  static bool get autoMatchDebug =>
      _environment["autoMatchDebug"] as bool? ?? false;
  static bool get simulateMembersJoining =>
      (_environment["simulateMembersJoining"] as bool? ?? false) && kDebugMode;
  static String get minimumRequiredVersion =>
      _environment["minimumRequiredVersion"] as String? ?? '0.0.0';
}
