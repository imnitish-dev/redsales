import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/screens/cart_screen/widgets/cart_item_list_widget.dart';
import 'package:twocliq/screens/cart_screen/widgets/from_wishlist_widget.dart';

import '../../helper/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cart",
                  style: customTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            /// Scrollable Content (cart + wishlist) takes remaining height
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  addressWidget(),
                  CartItemListWidget(),
                  FromWishlistWidget(),
                ],
              ),
            ),
            cartCheckoutWidget(),
          ],
        ),
      ),
    );
  }

  Widget addressWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shipping Address",
                  style: customTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                customSizedBox(height: 6.h),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas hendrerit luctus libero ac vulputate.",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          /// Red circular button
          GestureDetector(
            onTap: (){

            },
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: const BoxDecoration(
                color: Color(0xFFE91E3F), // red circle
                shape: BoxShape.circle,
              ),
              child:  Icon(
                FeatherIcons.edit2,
                color: Colors.white,
                size: 18.r,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget cartCheckoutWidget(){
    return Container(
      color:  const Color(0xFFFDF7F2),
      child: Padding(
        padding:  EdgeInsets.all(12.0.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: customTextStyle(fontSize: 14, color: Colors.black54),
                children: [
                  TextSpan(
                      text: "Total ",
                      style: customTextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold ,color: Colors.redAccent)),
                  TextSpan(
                      text: "₹",
                      style: customTextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold ,color: Colors.redAccent))
                  ,
                  TextSpan(
                      text: " 200",
                      style: customTextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold ,color: Colors.redAccent)
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: Padding(
                padding:  EdgeInsets.all(12.0.r),
                child: Row(
                 children: [
                   Icon(FeatherIcons.shoppingBag,color: Colors.white,size: 20.r),
                   customSizedBox(width: 5.w),
                   Text('Checkout',style: customTextStyle(color: Colors.white,fontSize: 18.sp))
                 ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
