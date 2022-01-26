import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/services/interfaces/i_auth.dart';
import 'package:tenders/widgets/common/custom/input.dart';
import 'package:tenders/widgets/common/custom/input_controllers.dart';
import 'package:tenders/widgets/common/custom/message_box.dart';
import 'package:tenders/widgets/common/custom/resize_input.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'package:tenders/widgets/common/displays/no_avatar.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';
import 'package:collection/collection.dart';
import 'dart:math' as math;
import 'dart:developer' as dev;

class SetupProfile extends StatefulWidget {
  final embedded;
  final Member? preloaded;
  final VoidCallback? onGo;
  const SetupProfile(
      {this.preloaded, this.embedded = true, Key? key, this.onGo})
      : super(key: key);
  @override
  State<SetupProfile> createState() => SetupProfileState();
}

class SetupProfileState extends State<SetupProfile> {
  Member? edited;
  late final InputController controller;
  bool loading = false;
  bool showTap = true;
  late int color;

  bool loadingFacebook = false;

  @override
  void initState() {
    super.initState();
    controller = InputController(text: widget.preloaded?.name ?? "");
    color = widget.preloaded?.color ??
        NoAvatar
            .PossibleColors[
                math.Random().nextInt(NoAvatar.PossibleColors.length)]
            .value;
    if (widget.preloaded == null) {
      GetIt.I<RoomAuthCubit>().getMember().then((value) {
        if (controller.text.isEmpty) {
          controller.text = value.name;
        }
        color = value.color;
        setState(() {
          edited = value;
        });
      });
    } else {
      edited = widget.preloaded;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body = SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                /// ugly but fast rn
                final current = Color(color);
                final currentIndex = NoAvatar.PossibleColors.indexOf(current);
                int next = currentIndex + 1;

                final length = NoAvatar.PossibleColors.length;
                if (next >= length) {
                  next = 0;
                }
                setState(() {
                  color = NoAvatar.PossibleColors[next].value;
                  edited = edited?.copyWith(color: color);
                  showTap = false;
                });
              },
              child: SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    Avatar(
                      member: edited,
                      size: Size(200, 200),
                      showInitial: false,
                    ),
                    if (showTap)
                      Positioned(
                        child: MessageBox(
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withAlpha(200),
                          message: "Tap to change!",
                        ),
                      )
                  ],
                ),
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
              controller: controller,
              keyboardType: TextInputType.name,
              onChanged: (val) {
                setState(() {
                  edited = edited?.copyWith(name: val);
                });
              },
              onSubmitted: (val) {
                if (!widget.embedded) {
                  _save();
                }
                widget.onGo?.call();
              },
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .headline4!
                        .color!
                        .withAlpha(155),
                    fontWeight: FontWeight.w300),
                hintText: "Name",
              ),
            ),
            if (!widget.embedded) ...[
              Expanded(
                child: SizedBox(),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: Text(
                      "Save",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    onPressed: _save,
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );

    /// add background
    if (!widget.embedded) {
      body = Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/stcharles.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(child: body),
          if (!widget.embedded)
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(child: SizedBox()),
                    if (loading) Loader() else _connectWithFacebookButton()
                  ],
                ),
              ),
            )
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: widget.embedded ? Colors.transparent : null,
        body: body,
      ),
    );
  }

  Future<void> _save() async {
    setState(() {
      loading = true;
    });
    try {
      final name = controller.text;
      edited = edited!.copyWith(name: name);
      await GetIt.I<RoomAuthCubit>().saveMember(edited!);
      Navigator.of(context).pop();
    } catch (er) {}
  }

  Widget _connectWithFacebookButton() {
    final hasProvider =
        FirebaseAuth.instance.currentUser?.providerData.firstOrNull;
    return InkWell(
        onTap: () async {
          if (hasProvider != null) {
            _disconnectFromFacebook();
          } else {
            _connectWithFacebook();
          }
        },
        child: Row(
          children: [
            Text(
              hasProvider == null ? "Add Profile" : "Remove Profile",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              width: 4,
            ),
            loadingFacebook
                ? Loader()
                : ClipOval(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset("assets/facebook_profile.png"),
                    ),
                  ),
            SizedBox(
              width: 8,
            ),
          ],
        ));
  }

  Future<void> _disconnectFromFacebook() async {
    final remove = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Failed to connect with Facebook"),
              content: Text(
                  "This will remove your facebook profile, name, and image from Tenders"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    "Remove",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
        ) ??
        false;

    if (remove) {
      setState(() {
        loadingFacebook = true;
      });
      final newData = await GetIt.I<RoomAuthCubit>().disconnectFromFacebook();
      setState(() {
        loadingFacebook = false;
      });
      if (newData != null) {
        setState(() {
          edited = newData;
          controller.text = newData.name;
        });
      } else {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Failed to disconnect from Facebook"),
              content: Text(
                  "Try again later. If this problem continues, contact support."),
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
      }
    }
  }

  Future<void> _connectWithFacebook() async {
    setState(() {
      loadingFacebook = true;
    });

    final newData = await GetIt.I<RoomAuthCubit>().connectWithFacebook();
    setState(() {
      loadingFacebook = false;
    });
    if (newData != null) {
      setState(() {
        edited = newData;
        controller.text = newData.name;
      });
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Failed to connect with Facebook"),
            content: Text(
                "Try again later. If this problem continues, contact support."),
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
    }
  }
}
