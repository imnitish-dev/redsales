import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

class TopBrandsScreen extends StatelessWidget {
  TopBrandsScreen({super.key});

  final List<String> brandImages = [
    "https://miro.medium.com/v2/resize:fit:1400/0*lNjDbMwBLRT6zCRF",
    "https://miro.medium.com/v2/resize:fit:1400/0*lNjDbMwBLRT6zCRF",
    "https://miro.medium.com/v2/resize:fit:1400/0*lNjDbMwBLRT6zCRF",
    "https://miro.medium.com/v2/resize:fit:1400/0*lNjDbMwBLRT6zCRF",
    "https://miro.medium.com/v2/resize:fit:1400/0*lNjDbMwBLRT6zCRF",
    "https://miro.medium.com/v2/resize:fit:1400/0*lNjDbMwBLRT6zCRF",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 9.h,left: 10.w),
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(FeatherIcons.chevronLeft,size: 30.r,color: Colors.black.withOpacity(0.4),)),
                  Text(
                    "Top Brands",
                    style: customTextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.9, // Adjust card height
                ),
                itemCount: brandImages.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      brandImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
