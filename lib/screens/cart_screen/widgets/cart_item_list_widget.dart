import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/provider/cart_provider.dart';
import 'package:twocliq/screens/product_detail_screen/product_detail_screen.dart';

import '../../../helper/animatedPage.dart';
import '../../../models/cart_list_model.dart';
import '../../../provider/home_provider.dart';
import '../../../services/cart_service.dart';

class CartItemListWidget extends StatefulWidget {
  const CartItemListWidget({super.key});

  @override
  State<CartItemListWidget> createState() => _CartItemListWidgetState();
}

class _CartItemListWidgetState extends State<CartItemListWidget> {
  bool isLoading = false;

  Widget emptyCartWidget() {
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: SvgPicture.asset('assets/svg/bag.svg', height: 40.r),
              )),
          customSizedBox(height: 15.h),
          Text(
            "No Items In Cart",
            style: customTextStyle(color: Colors.black, fontSize: 18.sp),
            textAlign: TextAlign.center,
          ),
          customSizedBox(height: 15.h),
          customSizedBox(height: 15.h)
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, _) {
        switch (provider.status) {
          case ApiLoadingState.loading:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.r,
                  width: 15.r,
                  child: Padding(
                    padding: EdgeInsets.all(13.r),
                    child: const CircularProgressIndicator(
                      color: Colors.redAccent,
                    ),
                  ),
                )
              ],
            );

          case ApiLoadingState.error:
            return Center(
              child: Text(
                provider.errorMessage ?? "Failed to load",
                style: const TextStyle(color: Colors.red),
              ),
            );

          case ApiLoadingState.success:
            return provider.cartList!.cartProducts.isEmpty
                ? Center(
                    child: emptyCartWidget(),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: provider.cartList!.cartProducts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = provider.cartList!.cartProducts[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: GestureDetector(
                          onTap: () {
                            if (item.productId != null) {
                              Navigator.of(context)
                                  .push(openAnimatedPage(ProductDetailScreen(productId: item.productId!)));
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Product Image with Delete
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.network(
                                        item.productImage ?? "",
                                        width: 120.w,
                                        height: 120.w,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          width: 120.w,
                                          height: 120.w,
                                          color: Colors.grey.shade200,
                                          child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                customSizedBox(width: 12.w),

                                /// Details and Quantity Controls
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productTitle ?? '',
                                        style: customTextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      customSizedBox(height: 6.h),

                                      item.price == null
                                          ? customSizedBox()
                                          : RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "₹ ",
                                                      style: customTextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.pink
                                                      )),
                                                  TextSpan(
                                                      text: item.price==null? "" : item.price.toString(),
                                                      style: customTextStyle(
                                                          fontSize: 17.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.pink
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),


                                      customSizedBox(height: 12.h),

                                      /// Quantity Selector
                                      Row(
                                        children: [
                                          GestureDetector(
                                            // onTap: () => _updateQuantity(index, -1),
                                            onTap: () async {
                                              logInfo('currentQty : ${item.quantity}');

                                              if (isLoading) {
                                                showCustomToast(msg: 'please try later..');
                                                return;
                                              }

                                              if (item.productId != null) {
                                                isLoading = true;
                                                HapticFeedback.mediumImpact();
                                                if (item.quantity! <= 1) {
                                                  if (item.cartId == null) {
                                                    showCustomToast(msg: "something went wrong!");
                                                    return;
                                                  }
                                                  bool isCartCleared =
                                                      await CartService.clearCart(cartId: item.cartId!);

                                                  logInfo("isCartCleared : $isCartCleared");

                                                  if (isCartCleared) {
                                                    CartListModel? cartList = await CartService.fetchCartData();
                                                    if (cartList.cartSummary?.totalAmount != null) {
                                                      provider.setCartDataManually(latestCartData: cartList);
                                                    }
                                                  }
                                                } else {
                                                  int tempQty = item.quantity! - 1;
                                                  bool isDataPushed = await CartService.addProductToCart(
                                                      productId: item.productId!, quantity: tempQty);
                                                  if (isDataPushed) {
                                                    CartListModel? cartList = await CartService.fetchCartData();
                                                    if (cartList.cartSummary?.totalAmount != null) {
                                                      provider.setCartDataManually(latestCartData: cartList);
                                                    }
                                                  }
                                                }
                                                isLoading = false;
                                              }
                                            },
                                            child: Container(
                                              width: 26.r,
                                              height: 26.r,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.pink, width: 1.5),
                                              ),
                                              child: const Icon(Icons.remove, color: Colors.pink),
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          GestureDetector(
                                            onTap: () {
                                              logInfo(item.productId);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                                              decoration: BoxDecoration(
                                                color: Colors.pink.shade50,
                                                borderRadius: BorderRadius.circular(8.r),
                                              ),
                                              child: Text(
                                                "${item.quantity}",
                                                style: customTextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          GestureDetector(
                                            // onTap: () => _updateQuantity(index, 1),
                                            onTap: () async {
                                              if (item.productId != null) {
                                                bool checkNet = await checkNetConnectivity();
                                                if (!checkNet) {
                                                  showErrorToast(msg: "internet connection not found!");
                                                  return;
                                                }

                                                //todo:  new flow

                                                HapticFeedback.mediumImpact();
                                                setState(() {
                                                  isLoading = true;
                                                });

                                                logInfo('current qty : ${item.quantity}');

                                                int tempQty = item.quantity! + 1;

                                                logInfo('latest qty : $tempQty');

                                                bool isDataPushed = await CartService.addProductToCart(
                                                    productId: item.productId!, quantity: tempQty);

                                                logInfo('isDataPushed : $isDataPushed');

                                                if (isDataPushed) {
                                                  CartListModel? cartList = await CartService.fetchCartData();

                                                  logInfo('isCartEmpty : ${cartList.cartProducts.isEmpty}');

                                                  if (cartList.cartSummary?.totalAmount != null) {
                                                    provider.setCartDataManually(latestCartData: cartList);
                                                  }
                                                }
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            },
                                            child: Container(
                                              width: 26.r,
                                              height: 26.r,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.pink, width: 1.5),
                                              ),
                                              child: Icon(Icons.add, color: Colors.pink, size: 25.r),
                                            ),
                                          ),
                                        ],
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
                  );
        }
      },
    );
  }
}
