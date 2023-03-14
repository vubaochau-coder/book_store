import 'package:book_store/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class BannerQuangCao extends StatefulWidget {
  const BannerQuangCao(this.items, {super.key});

  final List<Widget> items;

  @override
  State<BannerQuangCao> createState() => _BannerQuangCaoState();
}

class _BannerQuangCaoState extends State<BannerQuangCao> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          items: widget.items,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            height: 158,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 0,
          child: DotsIndicator(
            dotsCount: widget.items.length,
            axis: Axis.horizontal,
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              activeColor: themeColor,
              color: const Color.fromRGBO(224, 224, 224, 1),
              size: const Size.square(8.0),
              activeSize: const Size(24, 8),
              spacing: const EdgeInsets.all(4),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        )
      ],
    );
  }
}
