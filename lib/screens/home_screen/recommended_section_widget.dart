import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/screens/product_detail_screen/product_detail_screen.dart';

import '../../helper/animatedPage.dart';
import '../../models/home_screen/seperated_models/recommended_product_item_model.dart';

class ProductModel {
  final String imageUrl;
  final String title;
  final String description;
  final String price;

  ProductModel({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  });
}

class RecommendationSection extends StatefulWidget {
  const RecommendationSection({super.key});

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection> {
  int selectedCategory = 0;

  final List<String> categories = ["Face", "Eyes", "Lips", "Nails"];

  final List<ProductModel> products = [
    ProductModel(
      imageUrl:
      "https://www.bigbasket.com/media/uploads/flatpages/mailer-images-aug/265511_060325_1.jpg",
      title: "Granactive Retinoid 5%",
      description: "This water-free solution contains a 5% concentration of retinoid.",
      price: "₹699",
    ),
    ProductModel(
      imageUrl:
      "https://www.bigbasket.com/media/uploads/flatpages/mailer-images-aug/265511_060325_1.jpg",
      title: "Granactive Retinoid 2%",
      description: "Perfect starter solution with 2% retinoid concentration.",
      price: "₹499",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 15.w),
                  child: Text(
                    "Recommendation Product",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
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
          ),

          SizedBox(height: 16.h),

          /// Category Chips
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedCategory == index;
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedCategory = index);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          customSizedBox(height: 20.h),

          /// Horizontal Product Cards
          SizedBox(
            height: 290.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: EdgeInsets.only(right: 16.w,bottom: 10.h),
                  child: Container(
                    width: 230.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
                                child: Image.network(
                                  product.imageUrl,
                                  width: double.infinity,
                                  height: 150.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                left: 8.w,
                                child: Container(
                                  width: 32.w,
                                  height: 32.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white70,
                                  ),
                                  child: Icon(
                                    FeatherIcons.heart,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Product Details
                        Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                product.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade600,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.price,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Container(
                                    width: 32.w,
                                    height: 32.w,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child:  Icon(
                                      FeatherIcons.shoppingBag,
                                      color: Colors.white,
                                      size: 18.r,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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



class RecommendationSection2 extends StatefulWidget {
  final List<RecommendedCategoryModel> categories;

  const RecommendationSection2({
    super.key,
    required this.categories,
  });

  @override
  State<RecommendationSection2> createState() => _RecommendationSection2State();
}

class _RecommendationSection2State extends State<RecommendationSection2> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const SizedBox.shrink(); // Nothing to show
    }

    final selectedCategory = widget.categories[selectedCategoryIndex];
    final products = selectedCategory.products;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Text(
                    "Recommended Products",
                    style: customTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
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
          ),

          SizedBox(height: 16.h),

          /// Category Chips (from RecommendedCategory list)
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                final isSelected = selectedCategoryIndex == index;

                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedCategoryIndex = index);
                      HapticFeedback.selectionClick();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        category.categoryName,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          customSizedBox(height: 20.h),

          /// Horizontal Product Cards (for selected category)
          SizedBox(
            height: 290.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: EdgeInsets.only(right: 16.w, bottom: 10.h),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(openAnimatedPage(
                          ProductDetailScreen(productId: product.productId)
                      ));
                    },
                    child: Container(
                      width: 230.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                            child: Stack(
                              children: [
                                Image.network(
                                  product.imageUrl,
                                  width: double.infinity,
                                  height: 150.h,
                                  fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        height: 150.h,
                                        color: Colors.grey.shade200,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                          size: 40,
                                        ),
                                      );
                                    }
                                ),
                                Positioned(
                                  top: 8.h,
                                  left: 8.w,
                                  child: Container(
                                    width: 32.w,
                                    height: 32.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white70,
                                    ),
                                    child: Icon(
                                      FeatherIcons.heart,
                                      size: 18.r,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Product Details
                          Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  product.brand, // Replacing dummy description
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                    height: 1.3,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "₹${product.sellingPrice}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Container(
                                      width: 32.w,
                                      height: 32.w,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        FeatherIcons.shoppingBag,
                                        color: Colors.white,
                                        size: 18.r,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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

