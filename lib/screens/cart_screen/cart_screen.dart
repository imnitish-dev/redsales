import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/screens/cart_screen/payment_screen.dart';
import 'package:twocliq/screens/cart_screen/widgets/cart_item_list_widget.dart';
import 'package:twocliq/screens/cart_screen/widgets/from_wishlist_widget.dart';
import '../../helper/animatedPage.dart';
import '../../helper/constants.dart';
import '../../provider/cart_provider.dart';
import '../../provider/home_provider.dart';

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
                children: const [
                  // addressWidget(),
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

  Widget addressWidget() {
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
            onTap: () {},
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: const BoxDecoration(
                color: Color(0xFFE91E3F), // red circle
                shape: BoxShape.circle,
              ),
              child: Icon(
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

  Widget cartCheckoutWidget() {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.status == ApiLoadingState.success && cartProvider.cartList!.cartProducts.isNotEmpty
        ? Container(
            color: const Color(0xFFFDF7F2),
            child: Padding(
              padding: EdgeInsets.all(12.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<CartProvider>(
                    builder: (context, provider, _) {
                      switch (provider.status) {
                        case ApiLoadingState.loading:
                          return customSizedBox();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15.r,
                                width: 15.r,
                              )
                            ],
                          );

                        case ApiLoadingState.error:
                          return customSizedBox();
                          return Center(
                            child: Text(
                              "Failed to load",
                              style: customTextStyle(color: Colors.red, fontSize: 15.sp),
                            ),
                          );

                        case ApiLoadingState.success:
                          return provider.cartList?.cartSummary?.totalAmount == null
                              ? customSizedBox()
                              : RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: customTextStyle(fontSize: 14, color: Colors.black54),
                                    children: [
                                      TextSpan(
                                          text: "Total ",
                                          style: customTextStyle(
                                              fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.pink)),
                                      TextSpan(
                                          text: "₹",
                                          style: customTextStyle(
                                              fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.pink)),
                                      TextSpan(
                                          text: provider.cartList?.cartSummary?.totalAmount.toString(),
                                          style: customTextStyle(
                                              fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                                    ],
                                  ),
                                );

                        /* return ListView.builder(
             // padding: const EdgeInsets.all(16),
              itemCount: homeData.home.length,
              itemBuilder: (context, index) {
                final section = homeData.home[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (section.displayTitle.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          section.displayTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    _buildSection(section),
                    const SizedBox(height: 16),
                  ],
                );
              },
            );*/
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      if (cartProvider.status == ApiLoadingState.success) {
                        Navigator.of(context).push(openAnimatedPage(const PaymentScreen()));
                      }
                    },
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Padding(
                        padding: EdgeInsets.all(12.0.r),
                        child: Row(
                          children: [
                            Icon(FeatherIcons.shoppingBag, color: Colors.white, size: 20.r),
                            customSizedBox(width: 5.w),
                            Text('Checkout', style: customTextStyle(color: Colors.white, fontSize: 18.sp))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : customSizedBox();
  }
}
