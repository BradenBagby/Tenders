import 'package:tenders/core/utility/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Core {
  const Core._();

  /// initializes all tools before app starts
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await Injection.setup();
  }
}
