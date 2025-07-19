import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RandomProductShopNowWidget extends StatelessWidget {
   final String bannerImage;


  const RandomProductShopNowWidget({
    super.key,
    required this.bannerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all( Radius.circular(16.r)),
        child: Image.network(
          bannerImage, // Use your asset or network image
          width: double.infinity,
          height: 200.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}