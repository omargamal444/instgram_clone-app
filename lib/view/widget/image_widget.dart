import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  const ImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return Image.network(
        imageUrl,
        height: 70.0,
        width: 70.0,
        fit: BoxFit.fill,
      );
    } catch (e) {
      return const Icon(Icons.image);
    }
  }
}
