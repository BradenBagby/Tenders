import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class URLImage extends StatelessWidget {
  final String url;
  const URLImage(this.url);

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
        fit: BoxFit.cover,
      );
    }
  }
}
