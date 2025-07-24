import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/provider/cart_provider.dart';
import 'package:twocliq/provider/home_provider.dart';

import '../../../models/cart_list_model.dart';

class VoucherWidget extends StatefulWidget {
  const VoucherWidget({super.key});

  @override
  State<VoucherWidget> createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  String? selectedCouponId;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final appliedCoupon = cartProvider.cartList?.coupons.firstWhere(
      (c) => c.applied == true,
      orElse: () => Coupon(),
    );

    // Save selected coupon ID so it persists
    selectedCouponId ??= appliedCoupon?.couponId;

    // If no coupon is applied, pick the highest discount one
    final displayCoupon = appliedCoupon?.couponCode != null
        ? appliedCoupon
        : cartProvider.cartList!.coupons.isNotEmpty
            ? cartProvider.cartList?.coupons
                .reduce((a, b) => (a.maxDiscountAmount ?? 0) > (b.maxDiscountAmount ?? 0) ? a : b)
            : null;

    if (displayCoupon == null) {
      return const SizedBox.shrink(); // No coupons to display
    }

    final isApplied = appliedCoupon?.couponCode != null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Voucher",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.card_giftcard, color: Colors.pink),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            displayCoupon.description ?? "Special Offer",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showCouponSelector(context, cartProvider.cartList!.coupons);
                          },
                          child: Text(
                            "View all Vouchers >",
                            style: customTextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                isApplied
                    ? Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green,size: 25.r),
                          customSizedBox(width: 4.w),
                          Text(
                            "Applied",
                            style: customTextStyle(color: Colors.green),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 50.h,
                        width: 100.w,
                        child: ElevatedButton(
                          onPressed: () {
                            _showCouponSelector(context, cartProvider.cartList!.coupons);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color:  Colors.pink),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text("Apply", style: customTextStyle(color: Colors.pink)),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCouponSelector(BuildContext context, List<Coupon> coupons) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final cartProvider = Provider.of<CartProvider>(context, listen: false);

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 20,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Available Vouchers",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: coupons.length,
                        itemBuilder: (context, index) {
                          final coupon = coupons[index];
                          final isSelected = selectedCouponId == coupon.couponId;

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coupon.title ?? "Discount Coupon",
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      customSizedBox(height: 4),
                                      Text(
                                        coupon.description ?? "",
                                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                  width: 120.w,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (cartProvider.status == ApiLoadingState.loading) {
                                        showCustomToast(msg: "Please wait..");
                                        return;
                                      }

                                      await cartProvider.loadCartData(couponCode: coupon.couponCode);

                                      setModalState(() {
                                        selectedCouponId = coupon.couponId;
                                      });
                                      setState(() {
                                        selectedCouponId = coupon.couponId;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isSelected ? Colors.green : Colors.white,
                                      side:  BorderSide(color: isSelected ? Colors.transparent : Colors.pink),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      isSelected
                                          ? (cartProvider.status == ApiLoadingState.loading ? "Loading.." : "Applied")
                                          : "Apply",
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.pink,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
