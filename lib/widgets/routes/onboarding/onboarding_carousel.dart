import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenders/core/utility/permissions.dart';
import 'package:tenders/widgets/common/custom/page_indicator.dart';
import 'package:tenders/widgets/common/displays/chicken.dart';
import 'package:tenders/widgets/routes/onboarding/onbaording_pages.dart';

/// Shows each permissions onboarding page in sliding page fashion
class OnboardingCarousel extends StatefulWidget {
  @override
  _OnboardingCarouselState createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  // Navigator page push animation was rebuilding parent widget and causing pageController to be re-init multiple times. Stateful widget so it keeps its state throughout navigator animation
  final controller = PageController();

  final List<Widget> pages = [
    Container()
  ]; // init with empty container while we figure out what pages we need in initPages

  @override
  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {});
    });

    initPages();
  }

  /// build needed permission request pages. Those we already have access to -> skip
  Future<void> initPages() async {
    pages.clear();

    pages.add(WelcomePermissions(
      next: _next,
    ));

    /*if (!await Permissions.camera(request: false)) {
      pages.add(CameraPermissions());
    }*/

    if (!await Permissions.location(request: false)) {
      pages.add(LocationPermissions(
        next: _next,
      ));
    }

    pages.add(SetupProfileOnboarding(
      next: _next,
    ));

    // CALLS:COMMENT
    /*
    if (!await Permissions.calls(requestIfUnallowed: false)) {
      pages.add(
        CallPermissionPopup(
            embedded: true, onSuccess: _nextPage, onFail: _nextPage),
      );
    }*/

    // no permissions needed
    if (pages.isEmpty) {
      Navigator.of(context).pop();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
        )),
        Positioned.fill(
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/stcharles.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              /*leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  _close();
                },
              ),*/
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      children: pages,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  PageIndicator(
                    currentPage:
                        controller.hasClients ? controller.page!.round() : 0,
                    pageCount: pages.length,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

// MARK: internal functions ------

  void _next() {
    // close when we reach the end
    if (controller.page?.truncate() == pages.length - 1) {
      _close();
    }
    controller.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void _close() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('didCarousel', true);
      Navigator.of(context).pop();
    });
  }
}
