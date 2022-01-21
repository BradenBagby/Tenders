import 'package:flutter/material.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  final Restauraunt restauraunt;
  const Contact(this.restauraunt);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact",
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 4,
        ),
        InkWell(
          onTap: () {
            launch("tel:${formatPhone(restauraunt.formattedPhoneNumber)}");
          },
          child: Text(
            restauraunt.formattedPhoneNumber,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.blue),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        if (restauraunt.website != null)
          InkWell(
            onTap: () {
              launch(restauraunt.website!);
            },
            child: Text(restauraunt.website!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.blue)),
          ),
        SizedBox(
          height: 4,
        ),
        InkWell(
          onTap: () {
            launch(restauraunt.url);
          },
          child:
              Text(restauraunt.url, style: Theme.of(context).textTheme.caption),
        )
      ],
    );
  }
}
