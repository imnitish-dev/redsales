import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:twocliq/helper/constants.dart';

import '../../models/home_screen/seperated_models/top_product_model.dart';

class TopProduct {
  final String imageUrl;

  TopProduct({required this.imageUrl});
}


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
                  style: customTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
                child:  Icon(
                  FeatherIcons.chevronsRight,
                  color: Colors.white,
                  size: 20.r,
                ),
              ),
            ],
          ),

          customSizedBox(height: 16.h),

          /// Horizontal Scrollable Product Icons
          SizedBox(
            height: 90.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topProducts.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final product = topProducts[index];
                return GestureDetector(
                  onTap: () {
                    final clickDetails = product.clickDetails;
                    if (clickDetails != null) {
                      // Handle navigation or event
                      debugPrint(
                          "Navigate to ${clickDetails.targetScreen} with data: ${clickDetails.targetData?.typeValue}");
                    }
                  },
                  child: Center(
                    child: Image.network(
                      product.imageUrl ?? '',
                      width: 95.r,
                      height: 95.r,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, color: Colors.grey),
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