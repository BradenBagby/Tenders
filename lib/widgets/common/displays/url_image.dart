import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class URLImage extends StatelessWidget {
  final String url;
  final Widget? failedWidget;
  const URLImage(this.url, {this.failedWidget});

  @override
  Widget build(BuildContext context) {
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
