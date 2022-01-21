import 'dart:convert';

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
}
