import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';


class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  double selectedRating = 0;
  final TextEditingController commentController = TextEditingController();

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Write a Review",
                    style: customTextStyle(
                      fontSize: 20.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(FeatherIcons.x),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// User + Order Info
              Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: const NetworkImage(
                        "https://i.pravatar.cc/150?img=3"),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lorem ipsum dolor sit amet consectetur.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "Order #92287157",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// Star Rating Row
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = index + 1.0;
                      });
                    },
                    child: Icon(
                      index < selectedRating
                          ? Icons.star
                          : Icons.star_border,
                      size: 40.sp,
                      color: Colors.redAccent,
                    ),
                  );
                }),
              ),

              SizedBox(height: 20.h),

              /// Comment Box
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                height: 150.h,
                child: TextField(
                  controller: commentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Your Review",
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),

              ),

              const Spacer(),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => ReviewSuccessOverlay(
                        rating: selectedRating,
                        onDismiss: () => Navigator.pop(context),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text("Review Submitted!",style: customTextStyle(color: Colors.white)),backgroundColor: Colors.redAccent,),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "Say It!",
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
      ),
    );
  }
}


class ReviewSuccessOverlay extends StatelessWidget {
  final double rating;
  final int maxRating;
  final VoidCallback onDismiss;

  const ReviewSuccessOverlay({
    super.key,
    required this.rating,
    this.maxRating = 5,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7), // Dimmed background
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// White Card
            Container(
              width: 300.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customSizedBox(height: 50.h), // Space for circle
                  Text(
                    "Done!",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  customSizedBox(height: 8.h),
                  Text(
                    "Thank you for your review",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  customSizedBox(height: 20.h),

                  /// Star Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(maxRating, (index) {
                      return Icon(
                        index < rating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.redAccent,
                        size: 28.sp,
                      );
                    }),
                  ),
                ],
              ),
            ),

            /// Circle with Check Icon
            Positioned(
              top: -60.r,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 120.r,
                  height: 120.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink.shade50,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 60.r,
                      height: 60.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
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
