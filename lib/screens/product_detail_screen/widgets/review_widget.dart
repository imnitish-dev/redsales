import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helper/constants.dart';

class ReviewModel {
  final String profileImage;
  final String name;
  final double rating;
  final String review;

  ReviewModel({
    required this.profileImage,
    required this.name,
    required this.rating,
    required this.review,
  });
}

class RatingReviewsWidget extends StatelessWidget {
  final double averageRating;
  final int maxRating;
  final List<ReviewModel> reviews;
  final VoidCallback onViewAll;

  const RatingReviewsWidget({
    super.key,
    required this.averageRating,
    this.maxRating = 5,
    required this.reviews,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    // Format rating (remove .0 if it's a whole number)
    String formattedRating = (averageRating % 1 == 0)
        ? averageRating.toInt().toString()
        : averageRating.toStringAsFixed(1);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            "Rating & Reviews",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          customSizedBox(height: 12.h),

          /// Star rating summary
          Row(
            children: [
              ...List.generate(maxRating, (index) {
                return Icon(
                  index < averageRating.floor()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 24.sp,
                );
              }),
              customSizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "$formattedRating/$maxRating",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),

          /// Individual reviews (show top 2 for preview)
          ...reviews.take(2).map((review) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Profile image
                    CircleAvatar(
                      radius: 24.r,
                      backgroundImage: NetworkImage(review.profileImage),
                    ),
                    SizedBox(width: 12.w),

                    /// Name + Rating + Review
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name,
                            style: customTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.indigo.shade900,
                            ),
                          ),
                          Row(
                            children: List.generate(maxRating, (index) {
                              return Icon(
                                index < review.rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 16.sp,
                              );
                            }),
                          ),
                          customSizedBox(height: 4.h),
                          Text(
                            review.review,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: customTextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                customSizedBox(height: 16.h),
                if (reviews.indexOf(review) != reviews.take(2).length - 1)
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    height: 20,
                    indent: 40, // Leaves some gap on the left
                  ),
              ],
            );
          }),

          customSizedBox(height: 12.h),

          /// View all button
          Center(
            child: GestureDetector(
              onTap: onViewAll,
              child: Text(
                "View All Reviews",
                style: customTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
