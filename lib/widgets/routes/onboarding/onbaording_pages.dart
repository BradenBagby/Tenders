import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'dart:math' as math;

import 'package:tenders/core/utility/permissions.dart';
import 'package:app_settings/app_settings.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';
import 'package:tenders/widgets/routes/profile/setup_profile.dart';

class CameraPermissions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class LocationPermissions extends StatefulWidget {
  final VoidCallback next;
  const LocationPermissions({required this.next});

  @override
  State<LocationPermissions> createState() => _LocationPermissionsState();
}

class _LocationPermissionsState extends State<LocationPermissions> {
  bool needsSettings = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Allow Tenders to use your location",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Tenders uses your location to find restaurants nearby",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Icon(
                Icons.location_pin,
                size: 120,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text(
                      needsSettings ? "Open Settings" : "Continue",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    onPressed: () async {
                      if (needsSettings) {
                        AppSettings.openLocationSettings();
                        return;
                      }
                      final has = await Permissions.location();
                      if (has) {
                        widget.next();
                      } else {
                        setState(() {
                          needsSettings = true;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SetupProfileOnboarding extends StatefulWidget {
  final VoidCallback next;
  const SetupProfileOnboarding({required this.next});

  @override
  State<SetupProfileOnboarding> createState() => _SetupProfileOnboardingState();
}

class _SetupProfileOnboardingState extends State<SetupProfileOnboarding> {
  final profileKey = GlobalKey<SetupProfileState>();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Setup Profile",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Let your friends see who swiped what",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: SetupProfile(
              key: profileKey,
              onGo: _go,
            ),
          ),
          Opacity(
              opacity: loading ? 1 : 0,
              child: Column(
                children: [
                  Center(child: Loader()),
                  SizedBox(
                    height: 8,
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text(
                "Continue",
                style: Theme.of(context).textTheme.headline3,
              ),
              onPressed: _go,
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> _go() async {
    setState(() {
      loading = true;
    });
    try {
      Member edited = profileKey.currentState!.edited!;
      final name = profileKey.currentState!.controller.text;
      edited = edited.copyWith(name: name);
      await GetIt.I<RoomAuthCubit>().saveMember(edited);
    } catch (er) {}
    widget.next();
  }
}

class WelcomePermissions extends StatelessWidget {
  final VoidCallback next;
  const WelcomePermissions({required this.next});
  @override
  Widget build(BuildContext context) {
    final howToStyle = Theme.of(context).textTheme.headline6;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Tenders",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 8,
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset("assets/appIcon.jpg")),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.1, right: size.width * 0.1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How To:",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "1. Create a room",
                    style: howToStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "2. Invite friends",
                    style: howToStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "3. Swipe on nearby restaurants",
                    style: howToStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "4. Match and view results",
                    style: howToStyle,
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Center()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text(
                "Got It",
                style: Theme.of(context).textTheme.headline3,
              ),
              onPressed: next,
            ),
          ),
        ],
      ),
    );
  }
}


/*
          Text("Swipe with friends, match restaurants, decide where to eat!",
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(
              width: 200,
              child: Image.asset("assets/justTender.png"),
            ),
*/