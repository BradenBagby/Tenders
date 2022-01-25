import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/location.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tenders/widgets/common/custom/dropdown.dart';
import 'package:tenders/widgets/common/custom/input_controllers.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'package:tenders/widgets/common/displays/chicken.dart';
import 'package:tenders/widgets/root_widget.dart';
import 'package:tenders/widgets/routes/onboarding/onboarding_carousel.dart';
import 'package:tenders/widgets/routes/profile/setup_profile.dart';
import 'package:tenders/widgets/routes/scan/scan_page.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  bool moreOptions = false;
  bool opennow = false;
  PlaceType type = PlaceType.RESTAURAT;
  bool loading = false;
  late final InputController dropdownController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: ANIMATION_TIME));
    inAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    dropdownController = InputController(
      text: type.toUIString(),
    );

    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _profileButton(),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 64,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ScanPage()));
              },
              icon: Icon(
                Icons.qr_code_scanner_sharp,
              ),
            ),
          )),
        )
      ],
    ));
  }

  Widget _profileButton() {
    return BlocBuilder<RoomAuthCubit, RoomAuthState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => SetupProfile(
                        embedded: false,
                      ),
                  fullscreenDialog: true),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Avatar(
                  member: state.me,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(state.me?.name ?? "")
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _helpButton() {
    return IconButton(
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
    );
  }

  Widget _buttons() {
    return Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _goButton(context),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  moreOptions
                      ? _options()
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              moreOptions = true;
                            });
                          },
                          child: Text(
                            "Room Settings",
                            style: Theme.of(context).textTheme.caption,
                          ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _options() {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child: Dropdown(
            options: {
              for (var v in PlaceType.values) v.toUIString(): v.toUIString()
            },
            controller: dropdownController,
          ),
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
                //   checkColor: primaryColor,
                activeColor: primaryColor,
                value: opennow,
                onChanged: (val) {
                  setState(() {
                    opennow = val ?? !opennow;
                    ;
                  });
                }),
            Text("Must be open now")
          ],
        ),
      ],
    );
  }

  void _failed() {
    setState(() {
      loading = false;
    });
    goingIn = true;
    animationController.forward();
  }

  Widget _goButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          loading = true;
        });
        goingIn = false;
        animationController.reverse();
        final location = await TenderLocation.loadLocation();
        if (location == null ||
            location.latitude == null ||
            location.longitude == null) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Share Location"),
                content: Text(
                    "To see nearby restaurants, Tenders needs location permissions in your phone's settings"),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      AppSettings.openLocationSettings();
                    },
                    child: Text("Open Settings"),
                  ),
                ],
              );
            },
          );
          _failed();
          return;
        }

        final success =
            await BlocProvider.of<RoomAuthCubit>(context).createRoom(
          settings: RoomSettings(
            radius: (radiusMiles * MILES_TO_METERS).toInt(),
            type: PlaceTypeString.fromUIString(dropdownController.text),
            openNow: opennow,
            latitude: location.latitude!,
            longitude: location.longitude!,
          ),
        );
        if (!success) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Failed to create room"),
                content: Text(
                    "Try again later or contact support if this continues"),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Ok :("),
                  ),
                ],
              );
            },
          );
          _failed();
          return;
        }
      }, // TODO: if fail show message
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Create Room",
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 40),
        ),
      ),
    );
  }
}
