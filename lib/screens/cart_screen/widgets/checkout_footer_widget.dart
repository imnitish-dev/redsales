import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/provider/cart_provider.dart';
import 'package:twocliq/provider/customer_profile_provider.dart';
import 'package:twocliq/provider/orders_provider.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/order_history_screen.dart';
import 'package:twocliq/services/product_service.dart';

import '../../../helper/animatedPage.dart';
import '../../../helper/constants.dart';
import '../../../models/cart_list_model.dart';
import '../../../models/customer_profile_model.dart';

class CheckoutFooter extends StatefulWidget {
  Address? selectedAddress;
  CheckoutFooter({super.key, required this.selectedAddress});

  @override
  State<CheckoutFooter> createState() => _CheckoutFooterState();
}

class _CheckoutFooterState extends State<CheckoutFooter> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final customerProfileProvider = Provider.of<CustomerProfileProvider>(context);
    final orderProvider = Provider.of<OrdersProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Total ",
                      style: customTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "₹",
                      style: customTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.pink,
                      ),
                    ),
                    TextSpan(
                      text: cartProvider.cartList?.cartSummary?.totalAmount.toString() ?? "",
                      style: customTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showPaymentSummary(context);
                },
                child: RichText(
                  text: TextSpan(
                    text: "Payment Summary",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      color: Colors.yellow.shade800,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 60.h,
            width: 200.w,
            child: ElevatedButton(
              onPressed: () async {
                //  print(customerProfileProvider.customerProfile?.address?.state);



                final selectedAddress = widget.selectedAddress;

                if(selectedAddress!=null) {
                  List<CartProduct>? cartProducts = cartProvider.cartList?.cartProducts;

                  List<Map<String, dynamic>>? products = cartProducts?.map((product) {
                    return {
                      "productId": product.productId ?? "",
                      "quantity": product.quantity ?? 0,
                    };
                  }).toList();

                  /*if(products==null){
                    showErrorToast(msg: "something went wrong!");
                    return;
                  }

                  bool isPushed = await ProductService.placeOrder(
                      addressId: selectedAddress.addressId??"",
                      products: products,
                      itemAmount: cartProvider.cartList?.cartSummary.itemAmount,
                      taxAmount: taxAmount,
                      shippingAmount: shippingAmount,
                      finalAmount: finalAmount,
                      paymentMode: 'COD');
                }*/

                  if (products == null || products.isEmpty) {
                    showErrorToast(msg: "No products in cart!");
                    return;
                  }

                  if (selectedAddress?.addressId == null ||
                      cartProvider.cartList?.cartSummary?.itemAmount == null ||
                      cartProvider.cartList?.cartSummary?.taxAmount == null ||
                      //cartProvider.cartList?.cartSummary?. == null ||
                      cartProvider.cartList?.cartSummary?.totalAmount == null
                  ) {
                    showErrorToast(msg: "Something went wrong! Missing required details.");
                    return;
                  }

                  bool isPushed = await ProductService.placeOrder(
                    addressId: selectedAddress.addressId!,
                    products: products,
                    itemAmount: cartProvider.cartList!.cartSummary!.itemAmount!,
                    taxAmount: cartProvider.cartList!.cartSummary!.taxAmount!,
                    shippingAmount: 0,
                    finalAmount: cartProvider.cartList!.cartSummary!.totalAmount!,
                    paymentMode: 'COD',
                  );

                  if(isPushed){
                    showCustomToast(msg: "order confirmed!");
                    cartProvider.loadCartData();
                    await orderProvider.loadOrders();
                    Navigator.pop(context);
                    Navigator.of(context).push(openAnimatedPage(
                        OrderHistoryScreen()
                    ));

                  }else{
                    showCustomToast(msg: "something went wrong!");
                  }


                }


              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Colors.pink,
              ),
              child: Text("Pay", style: customTextStyle(color: Colors.white, fontSize: 20.sp)),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentSummary(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final cartProvider = Provider.of<CartProvider>(context);
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Payment Summary",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                DottedLine(
                  dashColor: Colors.grey.withOpacity(0.4),
                  dashLength: 5,
                  dashGapLength: 3,
                  lineThickness: 2,
                ),
                const SizedBox(height: 12),
                _buildSummaryRow("Item Total", "₹ ${cartProvider.cartList?.cartSummary?.itemAmount ?? ''}"),
                _buildSummaryRow("Discount Amount", "₹ ${cartProvider.cartList?.cartSummary?.discountAmount ?? ''}"),
                _buildSummaryRow("Tax Amount", "₹ ${cartProvider.cartList?.cartSummary?.taxAmount ?? ''}"),
                // _buildSummaryRow("Wallet Deduction", "₹00.00"),
                //_buildSummaryRow("Delivery Tip", "Add Tip", isLink: true),
                DottedLine(
                  dashColor: Colors.grey.withOpacity(0.4),
                  dashLength: 5,
                  dashGapLength: 3,
                  lineThickness: 2,
                ),
                const SizedBox(height: 8),
                _buildSummaryRow("To Pay", "₹ ${cartProvider.cartList?.cartSummary?.totalAmount ?? ''}", isBold: true),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isBold = false, bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isLink ? Colors.pink : Colors.grey.shade700,
              decoration: isLink ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isLink ? Colors.pink : Colors.black,
              decoration: isLink ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
