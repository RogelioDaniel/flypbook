import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  ImageCarousel({required this.imageUrls, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      options: CarouselOptions(
        height: 300,
        viewportFraction: 0.8,
        initialPage: 1,
        enableInfiniteScroll: false,
        reverse: true,
        onPageChanged: onPageChanged != null
            ? (index, reason) {
                onPageChanged!(index, reason);
              }
            : null,
      ),
      itemBuilder: (context, index, _) {
        if (index >= 0 && index < imageUrls.length) {
          return Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
