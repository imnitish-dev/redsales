import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

class ProductModel {
  final String imageUrl;
  final String description;
  final String price;

  ProductModel({
    required this.imageUrl,
    required this.description,
    required this.price,
  });
}

class YouMightLikeSection extends StatelessWidget {
  final List<ProductModel> products;

  const YouMightLikeSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Title
          Text(
            "You Might Like",
            style: customTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 16.h),

          /// Products Grid (2 columns)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.75, // Adjust for layout
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      height: 150.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 150.h,
                        width: 200.w,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Description
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 4.h),

                  /// Price
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
