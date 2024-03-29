import 'package:book_store/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductImagesSlider extends StatefulWidget {
  const ProductImagesSlider({super.key, required this.imgUrls});

  final List<String> imgUrls;

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 2 -
              kBottomNavigationBarHeight,
          width: double.infinity,
          padding: const EdgeInsets.all(2),
          child: CarouselSlider.builder(
            itemCount: widget.imgUrls.length,
            itemBuilder: (context, index, realIndex) {
              return CachedNetworkImage(
                imageUrl: widget.imgUrls[index],
                fit: BoxFit.fitHeight,
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: baseShimmer,
                    highlightColor: highlightShimmer,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              );
            },
            options: CarouselOptions(
              autoPlay: false,
              height: double.infinity,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 14,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              "${_currentIndex + 1}/${widget.imgUrls.length}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
