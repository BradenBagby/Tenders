import 'package:flutter/material.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';

class RestaurauntDisplay extends StatelessWidget {
  final Restauraunt restauraunt;
  const RestaurauntDisplay(this.restauraunt);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text(restauraunt.name),
      ),
    );
  }
}
