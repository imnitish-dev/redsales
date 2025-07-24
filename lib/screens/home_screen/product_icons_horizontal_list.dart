import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/models/home_screen/seperated_models/horizontal_icon_model.dart';

import '../../models/home_screen/home_screen_model.dart';

/*
class CategoryList extends StatelessWidget {
  final List<CategoryItem> categories = [
    CategoryItem(imagePath: "https://www.mcaffeine.com/cdn/shop/files/card_1b.jpg?v=1732871256", title: "Offers For You Offers For You Offers For You"),
    CategoryItem(imagePath: "https://www.mcaffeine.com/cdn/shop/files/card_1b.jpg?v=1732871256", title: "Best Deo"),
    CategoryItem(imagePath: "https://www.mcaffeine.com/cdn/shop/files/card_1b.jpg?v=1732871256", title: "Lotions"),
    CategoryItem(imagePath: "https://www.mcaffeine.com/cdn/shop/files/card_1b.jpg?v=1732871256", title: "Lip Care"),
    CategoryItem(imagePath: "https://www.mcaffeine.com/cdn/shop/files/card_1b.jpg?v=1732871256", title: "Skin Care"),
  ];

  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFDF7F2),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      height: 140.h,
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Padding(
            padding: EdgeInsets.only(right: 20.w,top: 10.h),
            child: Column(
              children: [
                ClipOval(
                  child: Image.network(
                    category.imagePath,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: 70.w,
                  child: Text(
                    category.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: customTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem {
  final String imagePath;
  final String title;

  CategoryItem({required this.imagePath, required this.title});
}*/

class ProductIconsHorizontalList extends StatelessWidget {
  final List<HorizontalIconModel> brands;
  final String? title;

  const ProductIconsHorizontalList({
    super.key,
    required this.brands,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFfffaf5),
      padding: EdgeInsets.symmetric(vertical: 4.h),
      height: 135.h,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                title!,
                style: customTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];
                return Padding(
                  padding: EdgeInsets.only(right: 5.w, top: 10.h),
                  child: Column(
                    children: [
                      ClipOval(
                        child: ClipOval(
                          child: Image.network(
                            brand.imageUrl,
                            width: 60.w,
                            height: 60.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60.w,
                                height: 60.w,
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image, color: Colors.grey, size: 24),
                              );
                            },
                          ),
                        ),
                      ),
                      customSizedBox(height: 8.h),
                      SizedBox(
                        width: 70.w,
                        child: Text(
                          brand.displayText??"",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
