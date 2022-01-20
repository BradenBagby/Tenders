import 'package:flutter/material.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/widgets/common/displays/photo_slider.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurauntDisplay extends StatelessWidget {
  final Restauraunt restauraunt;
  const RestaurauntDisplay(this.restauraunt);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          if (restauraunt.photos.isNotEmpty)
            Positioned.fill(
              child: URLImage(restauraunt.photos.first.url(
                  maxHeight: size.height.toInt() * 2,
                  maxWidth: size.width.toInt() * 2)),
            ),
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_overlay(context, size)],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _overlay(BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.black.withAlpha(100),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restauraunt.name,
              maxLines: 4,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            Row(
              children: [
                ...List.generate(restauraunt.rating.toInt(), (x) => x)
                    .map((e) => Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 16,
                        ))
                    .toList(),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            if (restauraunt.photos.length > 1)
              PhotoSlider(
                restauraunt.photos,
                height: size.height * 0.15,
              )
          ],
        ),
      ),
    );
  }
}
