import 'package:book_store/models/advertising_model.dart';
import 'package:book_store/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class BannerQuangCao extends StatefulWidget {
  const BannerQuangCao({super.key, required this.datas});

  final List<AdvertisingDataModel> datas;

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
        CarouselSlider.builder(
          itemCount: widget.datas.length,
          itemBuilder: (context, index, realIndex) {
            return Image.network(
              widget.datas[index].imgURL,
              fit: BoxFit.cover,
            );
          },
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
            dotsCount: widget.datas.length,
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
