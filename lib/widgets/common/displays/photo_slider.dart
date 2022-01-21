import 'package:flutter/material.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
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
              ...widget.photos.map(
                (e) => URLImage(
                  e.url(maxHeight: 250),
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
