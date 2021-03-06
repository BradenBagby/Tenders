import 'package:flutter/material.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/widgets/common/displays/photo_slider_pages.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';

class PhotoSlider extends StatefulWidget {
  final List<Photo> photos;
  final int startIndex;
  final double width;
  final void Function(Photo)? onPhotoSelected;
  const PhotoSlider(this.photos,
      {this.startIndex = 0, this.onPhotoSelected, this.width = 350});
  @override
  State<PhotoSlider> createState() => _PhotoSliderState();
}

class _PhotoSliderState extends State<PhotoSlider> {
  @override
  Widget build(BuildContext context) {
    if (widget.photos.length < 2) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Photos",
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 4,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GridView.count(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: [
              ...widget.photos.sublist(1).map(
                    (e) => InkWell(
                      onTap: () {
                        /// open photo slider
                        Navigator.of(context).push(FadePageRoute(Builder(
                          builder: (context) {
                            return PhotoSliderPages(
                              widget.photos,
                              startIndex: widget.photos.indexWhere((element) =>
                                  element.photoReference == e.photoReference),
                            );
                          },
                        ), isOpaque: false));
                      },
                      child: URLImage(
                        e.url(),
                        heroTag: e.photoReference,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ],
    );

    /** return SizedBox(
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            height: widget.height,
            child: URLImage(widget.photos[index].url(maxHeight: 50)),
          );
        },
        itemCount: widget.photos.length,
      ),
    ); */
  }
}
