import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagesCarousel extends StatefulWidget {
  final List<String> images;

  const ImagesCarousel({super.key, required this.images});

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = widget.images;

    return SizedBox(
      height: 400.h,
      width: double.infinity,
      child: Stack(
        children: [
          /// PageView Carousel
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: PageView.builder(
              controller: _pageController,
              itemCount: imageList.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    imageList[index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: Center(
                          child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          /// Instagram-style counter (Top-right)
          if (imageList.length > 1)
            Positioned(
              top: 16.h,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "${_currentPage + 1}/${imageList.length}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}