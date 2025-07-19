import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:twocliq/helper/constants.dart';

class FlashSaleItem {
  final String imageUrl;
  final int discount; // e.g., 20 for -20%

  FlashSaleItem({required this.imageUrl, required this.discount});
}

class FlashSaleSectionWidget extends StatefulWidget {
  const FlashSaleSectionWidget({super.key});

  @override
  State<FlashSaleSectionWidget> createState() => _FlashSaleSectionWidgetState();
}

class _FlashSaleSectionWidgetState extends State<FlashSaleSectionWidget> {
  late Timer _timer;
  int hours = 0;
  int minutes = 36;
  int seconds = 58;

  final List<FlashSaleItem> flashItems = [
    FlashSaleItem(imageUrl: "https://thesolvedskin.com/cdn/shop/files/GelmoisturiserA_3.jpg?v=1734521065&width=750", discount: 20),
    FlashSaleItem(imageUrl: "https://thesolvedskin.com/cdn/shop/files/GelmoisturiserA_3.jpg?v=1734521065&width=750", discount: 20),
    FlashSaleItem(imageUrl: "https://thesolvedskin.com/cdn/shop/files/GelmoisturiserA_3.jpg?v=1734521065&width=750", discount: 20),
    FlashSaleItem(imageUrl: "https://thesolvedskin.com/cdn/shop/files/GelmoisturiserA_3.jpg?v=1734521065&width=750", discount: 20),
    FlashSaleItem(imageUrl: "https://thesolvedskin.com/cdn/shop/files/GelmoisturiserA_3.jpg?v=1734521065&width=750", discount: 20),
    FlashSaleItem(imageUrl: "https://thesolvedskin.com/cdn/shop/files/GelmoisturiserA_3.jpg?v=1734521065&width=750", discount: 20),
  ];

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        if (minutes > 0) {
          setState(() {
            minutes--;
            seconds = 59;
          });
        } else if (hours > 0) {
          setState(() {
            hours--;
            minutes = 59;
            seconds = 59;
          });
        } else {
          _timer.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int value) => value.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header with Title + Countdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 15.w),
                child: Text(
                  "Flash Sale",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Row(
                children: [
                   Icon(FeatherIcons.clock, size: 25.r,color: Colors.red),
                  customSizedBox(width: 8.w),
                  _buildTimeBox(_formatTime(hours)),
                  _buildTimeSeparator(),
                  _buildTimeBox(_formatTime(minutes)),
                  _buildTimeSeparator(),
                  _buildTimeBox(_formatTime(seconds)),
                ],
              )
            ],
          ),

          SizedBox(height: 16.h),

          /// Product Grid (2 columns)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: flashItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final item = flashItems[index];
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Stack(
                    children: [
                      Image.network(
                        item.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0.0001.h,
                        right: 0.0001.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))
                          ),
                          child: Text(
                            "-${item.discount}%",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Timer box widget
  Widget _buildTimeBox(String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFCE8EB),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  /// Separator colon widget
  Widget _buildTimeSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Text(
        ":",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
