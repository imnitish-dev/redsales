import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:twocliq/helper/constants.dart';

class NewArrivalProduct {
  final String imageUrl;
  final String price;
  final String? oldPrice;
  final String? description;

  NewArrivalProduct({required this.imageUrl, required this.price, this.oldPrice, this.description});
}

class NewArrivalsSectionWidget extends StatelessWidget {
  NewArrivalsSectionWidget({super.key});

  final List<NewArrivalProduct> products = [
    NewArrivalProduct(
        imageUrl:
            "https://thesolvedskin.com/cdn/shop/files/Moisturiser_a3d3e0f5-4f29-4d69-a95c-9a787610730f.jpg?v=1718697353&width=1100",
        price: "₹699",
        oldPrice: "₹2999",
        description: 'Lorem ipsum dolor sit amet consectetur.'
    ),
    NewArrivalProduct(
      imageUrl:
          "https://thesolvedskin.com/cdn/shop/files/Moisturiser_a3d3e0f5-4f29-4d69-a95c-9a787610730f.jpg?v=1718697353&width=1100",
      price: "₹699",
        description: 'Lorem ipsum dolor sit amet consectetur.'
    ),
    NewArrivalProduct(
      imageUrl:
          "https://thesolvedskin.com/cdn/shop/files/Moisturiser_a3d3e0f5-4f29-4d69-a95c-9a787610730f.jpg?v=1718697353&width=1100",
      description: 'Lorem ipsum dolor sit amet consectetur.',
      price: "₹699",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Text(
                    "New Arrivals",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "View all",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    customSizedBox(width: 8.w),
                    Container(
                      width: 32.w,
                      height: 32.w,
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
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),


          SizedBox(
            height: 203.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Product Image Card
                      Container(
                        width: 130.w,
                        height: 130.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                          child: Stack(
                            children: [
                              Image.network(
                                product.imageUrl,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),

                              /// Add-to-cart Icon (Bottom Right)
                              Positioned(
                                bottom: 0.001.h,
                                right: 0.001.w,
                                child: Container(
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                    ),
                                  ),
                                  child: const Icon(
                                    FeatherIcons.plusCircle,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 6.h),

                      /// Product Description (1-2 lines max)
                      SizedBox(
                        width: 130.w,
                        child: Text(
                          product.description ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                            height: 1.3,
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      /// Price Row (With old price if available)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.price,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: Colors.red,
                            ),
                          ),
                          if (product.oldPrice != null) ...[
                            SizedBox(width: 8.w),
                            Text(
                              product.oldPrice!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ]
                        ],
                      ),




                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
