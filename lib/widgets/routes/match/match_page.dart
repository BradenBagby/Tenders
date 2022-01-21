import 'dart:math' as math;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/widgets/common/displays/restauraunt_display.dart';

class MatchPage extends StatefulWidget {
  final Restauraunt restauraunt;
  const MatchPage(this.restauraunt);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  late final ConfettiController controller;

  @override
  void initState() {
    controller = ConfettiController(duration: const Duration(milliseconds: 10));
    controller.play();
    super.initState();
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
                        "MATCH",
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
              numberOfParticles: 50,
              blastDirection: math.pi / 2,
            ),
          )
        ],
      ),
    ));
  }
}
