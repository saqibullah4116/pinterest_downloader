import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MediaPreview extends StatelessWidget {
  final String mediaUrl;
  final String mediaType;

  const MediaPreview({required this.mediaUrl, required this.mediaType});

  @override
  Widget build(BuildContext context) {
    if (mediaType == 'image' || mediaType == 'gif') {
      return CachedNetworkImage(
        imageUrl: mediaUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    } else if (mediaType == 'video') {
      return Icon(Icons.videocam, size: 100, color: Colors.red);
    } else {
      return Icon(Icons.error, size: 100, color: Colors.red);
    }
  }
}