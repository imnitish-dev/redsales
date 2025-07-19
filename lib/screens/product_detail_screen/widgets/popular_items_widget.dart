import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularItem {
  final String imageUrl;
  final int likes;
  final String label;

  PopularItem({required this.imageUrl, required this.likes, required this.label});
}

class MostPopularSection extends StatelessWidget {
  final List<PopularItem> items;
  final VoidCallback onViewAll;

  const MostPopularSection({
    super.key,
    required this.items,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header (Title + View All)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most Popular",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                GestureDetector(
                  onTap: onViewAll,
                  child: Row(
                    children: [
                      Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                         // decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      const Icon(Icons.arrow_forward, color: Colors.pink, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// Horizontal List of Cards
          SizedBox(
            height: 152.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Padding(
                    padding:  EdgeInsets.only(bottom: 6.h ),
                    child: Container(
                      width: 135.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                            child: Image.network(
                              item.imageUrl,
                              width: double.infinity,
                              height: 110.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 110.h,
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image, color: Colors.grey),
                              ),
                            ),
                          ),

                          /// Likes + Label
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${item.likes}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    const Icon(Icons.favorite, color: Colors.blue, size: 16),
                                  ],
                                ),
                                Text(
                                  item.label,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
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
