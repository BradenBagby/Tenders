import 'package:flutter/material.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';

class RestaurantRow extends StatelessWidget {
  final bool perfectMatch;
  final Restauraunt restauraunt;
  const RestaurantRow(this.restauraunt, {this.perfectMatch = true});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RootRouteController.showMatch(RootRouteController.key.currentContext!,
            restauraunt: restauraunt, perfectMatch: perfectMatch);
      },
      child: Container(
        height: 75,
        child: Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: 50,
                height: 50,
                child: URLImage(
                  restauraunt.photos.isNotEmpty
                      ? restauraunt.photos.first
                          .url(maxHeight: 100, maxWidth: 100)
                      : restauraunt.iconUrl,
                  failedWidget: URLImage(restauraunt.iconUrl),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                restauraunt.name,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
