import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helper/constants.dart';

class Voucher {
  final String title;
  final String subtitle;
  final String discountText;
  final String validity;
  final bool isHighlighted;
  final bool isCollected;

  Voucher({
    required this.title,
    required this.subtitle,
    required this.discountText,
    required this.validity,
    this.isHighlighted = false,
    this.isCollected = true,
  });
}

class ReferralCodesScreen extends StatelessWidget {
  final List<Voucher> vouchers = [
    Voucher(
      title: "Voucher",
      subtitle: "First Purchase",
      discountText: "5% off for your next order",
      validity: "Valid Until 4.21.20",
      isHighlighted: true,
      isCollected: true,
    ),
    Voucher(
      title: "Voucher",
      subtitle: "Gift From Customer Care",
      discountText: "15% off your next purchase",
      validity: "Valid Until 6.20.20",
    ),
    Voucher(
      title: "Voucher",
      subtitle: "Gift From Customer Care",
      discountText: "15% off your next purchase",
      validity: "Valid Until 6.20.20",
    ),
    Voucher(
      title: "Voucher",
      subtitle: "Gift From Customer Care",
      discountText: "15% off your next purchase",
      validity: "Valid Until 6.20.20",
    ),
  ];

  ReferralCodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            customSizedBox(height: 20.h),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(FeatherIcons.chevronLeft,size: 25.r)),
      customSizedBox(width: 5.w),
                Text("Wallet", style: customTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                final voucher = vouchers[index];
                return _buildVoucherCard(voucher);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherCard(Voucher voucher) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: voucher.isHighlighted ? Colors.yellow.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: voucher.isHighlighted ? Colors.orange : Colors.pink,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                voucher.title,
                style: customTextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                voucher.validity,
                style: customTextStyle(fontSize: 12.sp, color: Colors.black87),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          /// Subtitle + Discount Row
          Row(
            children: [
              Icon(Icons.card_giftcard,
                  color: voucher.isHighlighted ? Colors.orange : Colors.pink),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voucher.subtitle,
                      style: customTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      voucher.discountText,
                      style: customTextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (voucher.isCollected)
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child:  Text(
                    "Collected",
                    style: customTextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
