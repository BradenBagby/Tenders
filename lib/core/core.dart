import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenders/core/utility/dynamic_links.dart';
import 'package:tenders/core/utility/environment.dart';
import 'package:tenders/core/utility/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/widgets/routes/onboarding/onboarding_carousel.dart';

class Core {
  const Core._();

  /// initializes all tools before app starts
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
    await Firebase.initializeApp();
    await Environment.init();
    await Injection.setup();
  }

  /// called after runApp()
  static Future<void> postInit() async {
    await DynamicLinks.initDynamicLinks();
    await RootRouteController.listen();

    /// check if we have already viewed permission carousel, if not then show it
    Future.delayed(const Duration(milliseconds: 50)).then((value) async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool("didCarousel") != true) {
        Navigator.of(RootRouteController.key.currentContext!).push(
            MaterialPageRoute(
                builder: (_) => OnboardingCarousel(), fullscreenDialog: true));
      }
    });
  }
}
