import 'package:flutter/material.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/widgets/common/displays/restauraunt_display.dart';

class MatchPage extends StatelessWidget {
  final Restauraunt restauraunt;
  const MatchPage(this.restauraunt);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match"),
      ),
      body: RestaurauntDisplay(restauraunt),
    );
  }
}
