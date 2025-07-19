import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:twocliq/screens/top_brands_screen.dart';

import '../../helper/animatedPage.dart';

class TopBrandsWidget extends StatefulWidget {
  const TopBrandsWidget({super.key});

  @override
  State<TopBrandsWidget> createState() => _TopBrandsWidgetState();
}

class _TopBrandsWidgetState extends State<TopBrandsWidget> {
  final List<String> banners = [
    "https://miro.medium.com/v2/resize:fit:1400/0*lNjDbMwBLRT6zCRF",
    "https://miro.medium.com/v2/resize:fit:1400/0*lNjDbMwBLRT6zCRF",
    "https://miro.medium.com/v2/resize:fit:1400/0*lNjDbMwBLRT6zCRF",
  ];

  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header Row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Brands",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(openAnimatedPage(
                      TopBrandsScreen()
                  ));
                },
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    FeatherIcons.chevronsRight,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        /// Carousel Slider
        CarouselSlider.builder(
         // carouselController: _controller,
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  banners[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 320.h,
            autoPlay: true,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),

        SizedBox(height: 12.h),

        /// Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: _currentIndex == index ? 16.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.red : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4.r),
              ),
            );
          }),
        ),
      ],
    );
  }
}
