import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tenders/widgets/common/displays/chicken.dart';
import 'package:tenders/widgets/routes/scan/scan_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  double radiusMiles = 30.0;
  static const double MILES_TO_METERS = 1609;
  static const int ANIMATION_TIME = 300;

  late final AnimationController animationController;
  late final Animation inAnimation;

  bool goingIn = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: ANIMATION_TIME));
    inAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.1 + (0.2 - (0.2 * inAnimation.value)),
            child: Image.asset(
              'assets/stcharles.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Transform.translate(
              offset:
                  Offset(-size.width + (size.width * (inAnimation.value)), 0),
              child: _buttons()),
        ),
        Transform.translate(
          offset: Offset(size.width - (size.width * (inAnimation.value)), 0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Chicken(
              width: size.width / 2,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: IconButton(
              padding: EdgeInsets.only(right: 16),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Help"),
                      content: Text(
                          "To join your friend, have them tap the menu icon in the top left while searching for tendies. Scan the QR code with your camera"),
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
              },
              icon: Icon(Icons.help_outline_outlined),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ScanPage()));
              },
              icon: Icon(
                Icons.qr_code_scanner_sharp,
                size: 64,
              ),
            ),
          )),
        )
      ],
    ));
  }

  Widget _buttons() {
    return Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _goButton(context),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Within ${radiusMiles.toStringAsFixed(1)} miles",
                    style: Theme.of(context)
                        .textTheme
                        .overline!
                        .copyWith(fontSize: 15))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32),
              child: Slider(
                value: radiusMiles,
                onChanged: (val) {
                  setState(() {
                    radiusMiles = val;
                  });
                },
                min: 1,
                max: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _goButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        goingIn = false;
        animationController.reverse();
        await Future.delayed(const Duration(milliseconds: ANIMATION_TIME));
        BlocProvider.of<RoomAuthCubit>(context).createRoom(
            settings: RoomSettings(
                radius: (radiusMiles * MILES_TO_METERS).toInt(),
                type: PlaceType.RESTAURAT,
                openNow: false));
      }, // TODO: if fail show message
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Find Tendies",
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 40),
        ),
      ),
    );
  }
}
