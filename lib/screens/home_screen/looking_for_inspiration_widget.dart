import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

class InspirationCategory {
  final String name;
  final int count;
  final List<String> images;

  InspirationCategory({
    required this.name,
    required this.count,
    required this.images,
  });
}

class LookingForInspirationWidget extends StatelessWidget {
  LookingForInspirationWidget({super.key});

  final List<InspirationCategory> categories = [
    InspirationCategory(
      name: "Skin Care",
      count: 109,
      images: [
        "https://beautybybie.com/cdn/shop/files/anti_pigmentation_facial_kit.jpg?v=1749274359&width=533",
        "https://images.squarespace-cdn.com/content/v1/5e652fc4dc75b87df824ad24/1676359927010-XDCTRPQWYU9DHDA6APTF/TheSustainablist-Conscious-Beauty-Favorites-2022.JPG?format=1000w",
        "https://media.thebodyshop.in/media/wysiwyg/Tips-and-Advice/b11_sep_3.jpg",
        "https://hips.hearstapps.com/hmg-prod/images/malin-66836e35235a2.jpeg?crop=1.00xw:1.00xh;0,0&resize=1120:*",
      ],
    ),
    InspirationCategory(
      name: "Face Care",
      count: 530,
      images: [
        "https://images.squarespace-cdn.com/content/v1/5e652fc4dc75b87df824ad24/1676359927010-XDCTRPQWYU9DHDA6APTF/TheSustainablist-Conscious-Beauty-Favorites-2022.JPG?format=1000w",
        "https://beautybybie.com/cdn/shop/files/anti_pigmentation_facial_kit.jpg?v=1749274359&width=533",
        "https://hips.hearstapps.com/hmg-prod/images/malin-66836e35235a2.jpeg?crop=1.00xw:1.00xh;0,0&resize=1120:*",
        "https://media.thebodyshop.in/media/wysiwyg/Tips-and-Advice/b11_sep_3.jpg",
      ],
    ),
    InspirationCategory(
      name: "Lip Care",
      count: 87,
      images: [
        "https://hips.hearstapps.com/hmg-prod/images/malin-66836e35235a2.jpeg?crop=1.00xw:1.00xh;0,0&resize=1120:*",
        "https://media.thebodyshop.in/media/wysiwyg/Tips-and-Advice/b11_sep_3.jpg",
        "https://beautybybie.com/cdn/shop/files/anti_pigmentation_facial_kit.jpg?v=1749274359&width=533",
        "https://images.squarespace-cdn.com/content/v1/5e652fc4dc75b87df824ad24/1676359927010-XDCTRPQWYU9DHDA6APTF/TheSustainablist-Conscious-Beauty-Favorites-2022.JPG?format=1000w",
      ],
    ),
    InspirationCategory(
      name: "Hair Care",
      count: 218,
      images: [
        "https://hips.hearstapps.com/hmg-prod/images/malin-66836e35235a2.jpeg?crop=1.00xw:1.00xh;0,0&resize=1120:*",
        "https://media.thebodyshop.in/media/wysiwyg/Tips-and-Advice/b11_sep_3.jpg",
        "https://images.squarespace-cdn.com/content/v1/5e652fc4dc75b87df824ad24/1676359927010-XDCTRPQWYU9DHDA6APTF/TheSustainablist-Conscious-Beauty-Favorites-2022.JPG?format=1000w",
        "https://beautybybie.com/cdn/shop/files/anti_pigmentation_facial_kit.jpg?v=1749274359&width=533",
      ],
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
            padding:  EdgeInsets.only(left: 15.w),
            child: Text(
              "Looking for Inspiration",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          customSizedBox(height: 4.h),
          Padding(
            padding:  EdgeInsets.only(left: 15.w),
            child: Text(
              "See what's trending now.",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          /// 2-Column Grid for Categories
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.9,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
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
                child: Column(
                  children: [
                    /// 2×2 Grid of Images (4 images)
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemCount: category.images.length,
                        itemBuilder: (context, imgIndex) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Image.network(
                              category.images[imgIndex],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),

                    /// Title and Count Row
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              category.count.toString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
