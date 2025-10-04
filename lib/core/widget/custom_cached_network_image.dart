import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;
  final String? heroTag;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width = 220,
    this.height = 220,
    this.borderRadius = 16,
    this.fit = BoxFit.cover,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      fit: fit,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(color: AppColors.button,),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.music_note, size: 120, color: Colors.grey),
      ),
    );

    if (heroTag != null) {
      image = Hero(tag: heroTag!, child: image);
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.grey.shade200,
      ),
      clipBehavior: Clip.hardEdge,
      child: image,
    );
  }
}
