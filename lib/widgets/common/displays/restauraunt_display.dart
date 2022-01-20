import 'package:flutter/material.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';

class RestaurauntDisplay extends StatelessWidget {
  final Restauraunt restauraunt;
  const RestaurauntDisplay(this.restauraunt);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            restauraunt.name,
            style: Theme.of(context).textTheme.headline3,
          )
        ],
      ),
    );
  }
}
