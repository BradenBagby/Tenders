import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class URLImage extends StatelessWidget {
  final String url;
  final Widget? failedWidget;
  final String? heroTag;
  const URLImage(this.url, {this.failedWidget, this.heroTag});

  @override
  Widget build(BuildContext context) {
    if (heroTag != null) {
      return Hero(tag: heroTag!, child: _build(context));
    } else {
      return _build(context);
    }
  }

  Widget _build(BuildContext context) {
    if (kIsWeb) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        fit: BoxFit.cover,
        image: url,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: url,
        errorWidget: failedWidget != null
            ? (context, t, d) {
                return failedWidget!;
              }
            : null,
        fit: BoxFit.cover,
      );
    }
  }
}
