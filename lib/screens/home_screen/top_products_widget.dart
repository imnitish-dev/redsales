import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../models/home_screen/seperated_models/top_product_model.dart';

class TopProduct {
  final String imageUrl;

  TopProduct({required this.imageUrl});
}

/*class TopProductsSection extends StatelessWidget {
  TopProductsSection({super.key});

  final List<TopProduct> topProducts = [
    TopProduct(imageUrl: "assets/images/top_products_icons/item1.png"),
    TopProduct(imageUrl: "assets/images/top_products_icons/item2.png"),
    TopProduct(imageUrl: "assets/images/top_products_icons/item3.png"),
    TopProduct(imageUrl: "assets/images/top_products_icons/item4.png"),
    TopProduct(imageUrl: "assets/images/top_products_icons/item5.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Header (Title + Arrow Button)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 15.w),
                child: Text(
                  "Top Products",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FeatherIcons.chevronsRight,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          /// Horizontal Scrollable Product Icons
          SizedBox(
            height: 90.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topProducts.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final product = topProducts[index];
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Padding(
                    padding:  EdgeInsets.all(4.0.r),
                    child: Container(
                      width: 86.r,
                      height: 86.r,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF7F2), // Soft pink background

                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          product.imageUrl,
                          width: 35.w,
                          height: 35.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/

class TopProductsSection2 extends StatelessWidget {
  final List<TopProductModel> topProducts;

  const TopProductsSection2({
    super.key,
    required this.topProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Header (Title + Arrow Button)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Text(
                  "Top Products",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FeatherIcons.chevronsRight,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          /// Horizontal Scrollable Product Icons
          SizedBox(
            height: 90.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topProducts.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final product = topProducts[index];
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: GestureDetector(
                    onTap: () {
                      final clickDetails = product.clickDetails;
                      if (clickDetails != null) {
                        // Handle navigation or event
                        debugPrint(
                            "Navigate to ${clickDetails.targetScreen} with data: ${clickDetails.targetData?.typeValue}");
                      }
                    },
                    child: Container(
                      width: 86.r,
                      height: 86.r,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF7F2), // Soft pink background
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.network(
                          product.imageUrl ?? '',
                          width: 35.w,
                          height: 35.w,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
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