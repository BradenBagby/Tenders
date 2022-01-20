import 'package:flutter/material.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';

class PhotoSlider extends StatefulWidget {
  final List<Photo> photos;
  final int startIndex;
  final double height;
  final void Function(Photo)? onPhotoSelected;
  const PhotoSlider(this.photos,
      {this.startIndex = 0, this.onPhotoSelected, this.height = 50});
  @override
  State<PhotoSlider> createState() => _PhotoSliderState();
}

class _PhotoSliderState extends State<PhotoSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
