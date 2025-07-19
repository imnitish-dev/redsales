import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlashSaleProduct {
  final String imageUrl;
  final String description;
  final String price;
  final String oldPrice;
  final int discount;

  FlashSaleProduct({
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });
}

class FlashSaleScreen extends StatefulWidget {
  const FlashSaleScreen({super.key});

  @override
  State<FlashSaleScreen> createState() => _FlashSaleScreenState();
}

class _FlashSaleScreenState extends State<FlashSaleScreen> {
  int selectedDiscountIndex = 2;
  final List<String> discounts = ["All", "10%", "20%", "30%", "40%", "50%"];

  final List<FlashSaleProduct> products = List.generate(10, (index) {
    return FlashSaleProduct(
      imageUrl: "https://picsum.photos/200/30${index + 1}",
      description: "Lorem ipsum dolor sit amet consectetur",
      price: "₹699",
      oldPrice: "₹2999",
      discount: 20,
    );
  });

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
              /// Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Flash Sale",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Choose Your Discount",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.pink),
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: const Text("00"),
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: const Text("36"),
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: const Text("58"),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: 16.h),

              /// Discount Filters
              SizedBox(
                height: 40.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: discounts.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedDiscountIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedDiscountIndex = index),
                      child: Container(
                        margin: EdgeInsets.only(right: 12.w),
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.pink.shade50 : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: isSelected ? Colors.pink : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          discounts[index],
                          style: TextStyle(
                            color: isSelected ? Colors.pink : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                "20% Discount",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 12.h),

              /// Grid + Banner in the middle
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: products.length + 1, // Extra for banner
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 4) {
                      // Add banner at 5th position
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        width: double.infinity,
                        height: 120.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.black,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            "https://picsum.photos/400/100",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }

                    final product = products[index > 4 ? index - 1 : index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                                child: Image.network(
                                  product.imageUrl,
                                  width: double.infinity,
                                  height: 140.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      height: 140.h,
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                right: 8.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    "-${product.discount}%",
                                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Text(
                                      product.price,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                        color: Colors.pink,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      product.oldPrice,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
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
