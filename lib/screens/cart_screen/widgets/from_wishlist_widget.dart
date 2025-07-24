import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/provider/cart_provider.dart';
import 'package:twocliq/provider/wishlist_provider.dart';
import 'package:twocliq/services/cart_service.dart';
import 'package:twocliq/services/wishlist_service.dart';
import '../../../helper/animatedPage.dart';
import '../../../models/cart_list_model.dart';
import '../../../models/wishlist_model.dart';
import '../../../provider/home_provider.dart';
import '../../product_detail_screen/product_detail_screen.dart';

class FromWishlistWidget extends StatefulWidget {
  const FromWishlistWidget({super.key});

  @override
  State<FromWishlistWidget> createState() => _FromWishlistWidgetState();
}

class _FromWishlistWidgetState extends State<FromWishlistWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
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
            return customSizedBox();
            return Center(
              child: Text(
                provider.errorMessage ?? "Failed to load",
                style: const TextStyle(color: Colors.red),
              ),
            );

          case ApiLoadingState.success:
            return provider.wishlist!.isEmpty
                ? customSizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26.w),
                        child: Text(
                          "From Your Wishlist",
                          style: customTextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      customSizedBox(height: 12.h),
                      ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: provider.wishlist!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = provider.wishlist![index];
                          return wishlistWidget(currentWishlist: item);
                        },
                      ),
                    ],
                  );
        }
      },
    );
  }

  Widget wishlistWidget({required WishlistItem currentWishlist}) {
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishlistProvider>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: () {
          if (currentWishlist.productId != null) {
            Navigator.of(context).push(openAnimatedPage(ProductDetailScreen(productId: currentWishlist.productId!)));
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Product Image + Delete Button
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  currentWishlist.productImage ?? "",
                  width: 120.r,
                  height: 120.r,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 120.r,
                    height: 120.r,
                    color: Colors.grey.shade200,
                    child: Icon(Icons.broken_image, size: 40.r, color: Colors.grey),
                  ),
                ),
              ),
              customSizedBox(width: 12.w),

              /// Description + Price + Size + Add to Cart
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentWishlist.productTitle ?? "",
                      style: customTextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    customSizedBox(height: 6.h),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "₹ ",
                              style: customTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.pink)),
                          TextSpan(
                              text: currentWishlist.priceDetails?.sellingPrice == null
                                  ? ""
                                  : currentWishlist.priceDetails!.sellingPrice.toString(),
                              style: customTextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500, color: Colors.pink)),
                        ],
                      ),
                    ),
                    customSizedBox(height: 8.h),
                    Row(
                      children: [
                        const Spacer(),
                        Container(
                          width: 36.r,
                          height: 36.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.pink.shade50,
                          ),
                          child: IconButton(
                              onPressed: () async {
                                if (currentWishlist.wishlistId != null) {
                                  bool isRemovedFromWishlist = await WishlistService.deleteWishlistItemUsingWishlistID(
                                      wishlistId: currentWishlist.wishlistId!);
                                  if (isRemovedFromWishlist) {
                                    var tempWishlist = await WishlistService.fetchWishlist();
                                    wishListProvider.setWishlistManually(newWishlist: tempWishlist);
                                    showCustomToast(msg: 'Deleted product from wishlist');
                                  } else {
                                    showErrorToast(msg: 'failed to delete item from wishlist');
                                  }
                                } else {
                                  showErrorToast(msg: 'failed to delete item from wishlist');
                                }
                              },
                              icon: Icon(FeatherIcons.trash, color: Colors.pink, size: 20.r)),
                        ),
                        customSizedBox(width: 10.w),
                        Container(
                          width: 36.r,
                          height: 36.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.pink.shade50,
                          ),
                          child: IconButton(
                              onPressed: () async {
                                logInfo("started to add item to cart");
                                if (currentWishlist.productId != null) {
                                  logInfo("productID : ${currentWishlist.productId}");

                                  int currentQty = 0;
                                  logInfo("old qty :$currentQty");
                                  CartProduct? sameItemFromCart = cartProvider.cartList?.cartProducts
                                      .firstWhereOrNull((element) => element.productId == currentWishlist.productId);

                                  if (sameItemFromCart != null && sameItemFromCart.quantity != null) {
                                    logInfo("found same item in cart already..");
                                    currentQty = sameItemFromCart.quantity!;
                                  }

                                  currentQty = currentQty + 1;

                                  logInfo("new qty :$currentQty");

                                  bool isAddedToCart = await CartService.addProductToCart(
                                      productId: currentWishlist.productId!, quantity: currentQty);
                                  if (isAddedToCart) {
                                    logInfo("added item to cart , refreshing cart");
                                    var temp = await CartService.fetchCartData();
                                    if (temp.cartSummary?.totalAmount != null) {
                                      logInfo("cart refreshed");
                                      cartProvider.setCartDataManually(latestCartData: temp);
                                      logInfo("cart updated!");
                                      showCustomToast(msg: "Added to Cart!");
                                    } else {
                                      logError("failed to refresh cart");
                                      showCustomToast(msg: "failed to add to cart..");
                                    }
                                  } else {
                                    logError('failed to add item to cart');
                                    showCustomToast(msg: "failed to add to cart..");
                                  }
                                }
                              },
                              icon: Icon(FeatherIcons.shoppingBag, color: Colors.pink, size: 20.r)),
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
  }
}
