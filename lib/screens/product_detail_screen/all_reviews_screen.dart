import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/constants.dart';

class Review {
  final String profileImage;
  final String name;
  final double rating;
  final String reviewText;

  Review({
    required this.profileImage,
    required this.name,
    required this.rating,
    required this.reviewText,
  });
}

class AllReviewsScreen extends StatelessWidget {
  AllReviewsScreen({super.key});

  // Sample list of reviews (could come from API)
  final List<Review> reviews = [
    Review(
      profileImage: "https://i.pravatar.cc/150?img=1",
      name: "Veronika Singhania",
      rating: 1,
      reviewText:
      "Lorem ipsum dolor sit amet, consectetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.",
    ),
    Review(
      profileImage: "https://i.pravatar.cc/150?img=2",
      name: "Veronika Singhania",
      rating: 4,
      reviewText:
      "Lorem ipsum dolor sit amet, consectetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.",
    ),
    Review(
      profileImage: "https://i.pravatar.cc/150?img=3",
      name: "Veronika Singhania",
      rating: 5,
      reviewText:
      "Lorem ipsum dolor sit amet, consectetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.",
    ),
    Review(
      profileImage: "https://i.pravatar.cc/150?img=4",
      name: "Veronika Singhania",
      rating: 5,
      reviewText:
      "Lorem ipsum dolor sit amet, consectetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Reviews",
                    style: customTextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Profile Image
                          CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.shade200, // Background for fallback
                            child: ClipOval(
                              child: Image.network(
                                review.profileImage,
                                fit: BoxFit.cover,
                                width: 48.w,
                                height: 48.w,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.person, // Fallback icon
                                    size: 28.sp,
                                    color: Colors.grey.shade500,
                                  );
                                },
                              ),
                            ),
                          ),
                          customSizedBox(width: 12.w),
        
                          /// Name, Rating, and Review
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < review.rating.floor()
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 18.sp,
                                    );
                                  }),
                                ),
                                customSizedBox(height: 4.h),
                                Text(
                                  review.reviewText,
                                 // maxLines: 3,
                                   //overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade700,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (index != reviews.length - 1) ...[
                        customSizedBox(height: 16.h),
                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 0.8,
                          height: 20,
                          indent: 40, // Leaves gap aligned with avatar
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
        
            /// Bottom Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                onPressed: () {
                  /// Handle "Write a Review"
                },
                child: Text(
                  "Write a Review",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
