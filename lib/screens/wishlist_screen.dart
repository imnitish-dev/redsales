import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class WishlistProduct {
  final String imageUrl;
  final String description;
  final String price;
  final String size;

  WishlistProduct({
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.size,
  });
}

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {


  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }

  final List<WishlistProduct> cartProducts = [
    WishlistProduct(
      imageUrl: "https://picsum.photos/200/300",
      description: "Lorem ipsum dolor sit amet consectetur.",
      price: "₹699",
      size: "20 ml",
    ),
    WishlistProduct(
      imageUrl: "https://picsum.photos/200/301",
      description: "Lorem ipsum dolor sit amet consectetur.",
      price: "₹699",
      size: "20 ml",
    ),
    WishlistProduct(
      imageUrl: "https://picsum.photos/200/302",
      description: "Lorem ipsum dolor sit amet consectetur.",
      price: "₹699",
      size: "20 ml",
    ),
    WishlistProduct(
      imageUrl: "https://picsum.photos/200/303",
      description: "Lorem ipsum dolor sit amet consectetur.",
      price: "₹699",
      size: "20 ml",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      FeatherIcons.chevronLeft,
                      size: 30.r,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  Text(
                    "Wishlist",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              /// Product List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Product Image with Delete Icon
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  product.imageUrl,
                                  width: 120.w,
                                  height: 120.w,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 120.w,
                                      height: 120.w,
                                      color: Colors.grey.shade200,
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.broken_image,
                                          color: Colors.grey, size: 40),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 8.h,
                                left: 8.w,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cartProducts.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 12.w),

                          /// Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.description,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  product.price,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: Colors.pink.shade50,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    product.size,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Add-to-cart Icon
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 36.w,
                              height: 36.w,
                              margin: EdgeInsets.only(top: 80.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.pink.shade50,
                              ),
                              child: const Icon(Icons.add_shopping_cart,
                                  color: Colors.pink),
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
        ),
      ),
    );
  }
}

