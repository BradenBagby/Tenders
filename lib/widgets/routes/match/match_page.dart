import 'dart:math' as math;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/widgets/common/custom/message_box.dart';
import 'package:tenders/widgets/common/displays/restauraunt_display.dart';
import 'package:tenders/widgets/root_widget.dart';
import 'package:collection/collection.dart';

class MatchPage extends StatefulWidget {
  final Restauraunt restauraunt;
  final bool totalMatch;
  const MatchPage(this.restauraunt, {this.totalMatch = true});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  late final ConfettiController controller;

  @override
  void initState() {
    controller = ConfettiController(duration: const Duration(milliseconds: 10));
    if (widget.totalMatch) controller.play();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                    ),
                    Expanded(
                      child: Text(
                        "${widget.totalMatch ? 'PERFECT ' : ''}MATCH",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        MapsLauncher.launchQuery(widget.restauraunt.address);
                      },
                      icon: Icon(Icons.drive_eta),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: RestaurauntDisplay(widget.restauraunt),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: controller,
              blastDirectionality: BlastDirectionality.directional,
              shouldLoop: false,
              emissionFrequency: 1,
              gravity: 0,
              numberOfParticles: 12,
              blastDirection: math.pi / 2,
            ),
          ),
          if (GetIt.I<RoomAuthCubit>() // only show on first match. doesnt emit a match until after this screen is closed
                  .state
                  .currentRoomCubit
                  ?.state
                  .matches
                  .isEmpty ??
              false)
            Positioned(
                top: 32,
                left: 18,
                child: MessageBox(
                  flipped: false,
                  flippedY: true,
                  color: primaryColor,
                  message: "Close to continue swiping",
                  style: TextStyle(color: Colors.white),
                ))
        ],
      ),
    ));
  }
}
