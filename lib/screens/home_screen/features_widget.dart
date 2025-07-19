import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureItem {
  final String iconUrl;
  final String title;
  final String subtitle;

  FeatureItem({
    required this.iconUrl,
    required this.title,
    required this.subtitle,
  });
}

class FeaturesSectionWidget extends StatelessWidget {
  FeaturesSectionWidget({super.key});

  final List<FeatureItem> features = [
    FeatureItem(
      iconUrl: "assets/images/shipping.png",
      title: "Free Shipping",
      subtitle: "Above ₹399",
    ),
    FeatureItem(
      iconUrl: "assets/images/return.png",
      title: "Easy Returns",
      subtitle: "10 Days",
    ),
    FeatureItem(
      iconUrl: "assets/images/genuine.png",
      title: "100% Genuine",
      subtitle: "Products",
    ),
    FeatureItem(
      iconUrl: "assets/images/brands.png",
      title: "3000+ Brands",
      subtitle: "15L+ Products",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFDF7F2),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Keep it non-scrollable
        itemCount: features.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1.3, // Adjust aspect ratio for layout balance
        ),
        itemBuilder: (context, index) {
          final feature = features[index];
          return Column(
           /// mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Circular Icon with border
              Container(
                width: 60.w,
                height: 80.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.pink, width: 2),
                ),
                child: Image.asset(
                  feature.iconUrl,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10.h),

              /// Title
              Text(
                feature.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),

              /// Subtitle
              Text(
                feature.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          );
        },
      ),
    );

  }
}
