import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/models/home_screen/seperated_models/horizontal_banner_model.dart';

import '../../models/home_screen/home_screen_model.dart';

class BeautyCarousel extends StatefulWidget {
  const BeautyCarousel({super.key});

  @override
  State<BeautyCarousel> createState() => _BeautyCarouselState();
}

class _BeautyCarouselState extends State<BeautyCarousel> {
  int _currentIndex = 0;

  final List<String> _images = [
    "https://www.kaya.in/media/catalog/product/cache/4bffdb0e5cb0703e5476bde8a2e0010a/p/r/product_with_bg_3.jpg",
    "https://www.kaya.in/media/catalog/product/cache/4bffdb0e5cb0703e5476bde8a2e0010a/p/r/product_with_bg_3.jpg",
    "https://www.kaya.in/media/catalog/product/cache/4bffdb0e5cb0703e5476bde8a2e0010a/p/r/product_with_bg_3.jpg",
    "https://www.kaya.in/media/catalog/product/cache/4bffdb0e5cb0703e5476bde8a2e0010a/p/r/product_with_bg_3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Carousel with edited images
        CarouselSlider.builder(
          itemCount: _images.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                _images[index],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          },
          options: CarouselOptions(
            height: 180.h,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),

        SizedBox(height: 12.h),


        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_images.length, (index) {
            final isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: 8.h,
              width: isActive ? 20.w : 8.w,
              decoration: BoxDecoration(
                color: isActive ? Colors.red : Colors.red.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4.r),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class BannerCarousel extends StatefulWidget {
  final List<HorizontalBannerModel> banners;

  const BannerCarousel({Key? key, required this.banners}) : super(key: key);

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.banners.length,
          itemBuilder: (context, index, realIndex) {
            final banner = widget.banners[index];
            return GestureDetector(
              onTap: () {
                // Handle banner click (navigate based on clickDetails)
                final target = banner.clickDetails?.targetScreen;
                final targetData = banner.clickDetails?.targetData;
                debugPrint("Clicked Banner -> $target : $targetData");
                // TODO: Implement navigation logic based on target
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  banner.imageUrl??"",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, size: 40),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 180.h,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (index) {
            final isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: isActive ? 20 : 8,
              decoration: BoxDecoration(
                color: isActive ? Colors.red : Colors.red.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

