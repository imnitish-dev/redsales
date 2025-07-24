import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/models/home_screen/seperated_models/shop_by_category_model.dart';

class ShopByItem {
  final String imageUrl;
  final String label;

  ShopByItem({required this.imageUrl, required this.label});
}

class ShopByCategoryWidget extends StatelessWidget {
  ShopByCategoryWidget({super.key});

  final List<ShopByItem> shopItems = [
    ShopByItem(
      imageUrl:
          "https://www.mcaffeine.com/cdn/shop/files/card_7_f6af5207-8b37-4b2e-9419-146cf3746221.jpg?v=1732873232&width=1445",
      label: "Categories",
    ),
    ShopByItem(
      imageUrl:
          "https://www.mcaffeine.com/cdn/shop/files/card_7_f6af5207-8b37-4b2e-9419-146cf3746221.jpg?v=1732873232&width=1445",
      label: "Brands",
    ),
    ShopByItem(
      imageUrl:
          "https://www.mcaffeine.com/cdn/shop/files/card_7_f6af5207-8b37-4b2e-9419-146cf3746221.jpg?v=1732873232&width=1445",
      label: "Markeup",
    ),
    ShopByItem(
      imageUrl:
          "https://www.mcaffeine.com/cdn/shop/files/card_7_f6af5207-8b37-4b2e-9419-146cf3746221.jpg?v=1732873232&width=1445",
      label: "Luxe",
    ),
    ShopByItem(
      imageUrl:
          "https://www.mcaffeine.com/cdn/shop/files/card_7_f6af5207-8b37-4b2e-9419-146cf3746221.jpg?v=1732873232&width=1445",
      label: "New Launch",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              "Shop By",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          customSizedBox(height: 16.h),

          /// Grid Layout
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shopItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 items per row
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.9, // Adjust for spacing
            ),
            itemBuilder: (context, index) {
              final item = shopItems[index];
              return GestureDetector(
                onTap: () {
                  // Handle navigation or action
                },
                child: Column(
                  children: [
                    /// Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Image.network(
                        item.imageUrl,
                        width: 100.r,
                        height: 100.r,
                        fit: BoxFit.cover,
                      ),
                    ),

                    customSizedBox(height: 8.h),

                    /// Label
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shopItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Always 2 items per row
              mainAxisSpacing: 0.h,
              crossAxisSpacing: 15.w,
              childAspectRatio: 1, // Adjust height/width ratio
            ),
            itemBuilder: (context, index) {
              final item = shopItems[index];
              return GestureDetector(
                onTap: () {
                  // Handle navigation or tap
                },
                child: Column(
                  children: [
                    /// Image container with equal width
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        item.imageUrl,
                        width: double.infinity, // Stretches to half screen
                        height: 120.h,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    /// Label text
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}


class ShopBySectionWidget2 extends StatelessWidget {
  final String title;
  final List<ShopByCategoryModel> shopItems;

  const ShopBySectionWidget2({
    super.key,
    required this.title,
    required this.shopItems,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              "Shop By",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          customSizedBox(height: 16.h),

          /// Grid Layout
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shopItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0.h,
              crossAxisSpacing: 0.w,
              childAspectRatio: 0.8, // Adjust for spacing
            ),
            itemBuilder: (context, index) {
              final item = shopItems[index];

             // return Text(item.displayText);

              return GestureDetector(
                onTap: () {
                  // Handle navigation or action
                },
                child: Column(
                  children: [
                    /// Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Image.network(
                        item.imageUrl,
                        width: 100.r,
                        height: 100.r,
                        fit: BoxFit.contain,
                      ),
                    ),


                    /// Label
                    Text(
                      item.displayText,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
