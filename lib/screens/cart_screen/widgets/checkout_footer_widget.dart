import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/provider/cart_provider.dart';
import 'package:twocliq/provider/customer_profile_provider.dart';
import 'package:twocliq/services/product_service.dart';

import '../../../helper/constants.dart';

class CheckoutFooter extends StatefulWidget {


   const CheckoutFooter({super.key});

  @override
  State<CheckoutFooter> createState() => _CheckoutFooterState();
}

class _CheckoutFooterState extends State<CheckoutFooter> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final customerProfileProvider = Provider.of<CustomerProfileProvider>(context);
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
                      text: cartProvider.cartList?.cartSummary?.totalAmount.toString()??"", // now using widget.total"
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
                print(customerProfileProvider.customerProfile?.address?.state);
               /* bool isPushed = await ProductService.placeOrder(
                    addressId: addressId,
                    products: products,
                    itemAmount: itemAmount,
                    taxAmount: taxAmount,
                    shippingAmount: shippingAmount,
                    finalAmount: finalAmount,
                    paymentMode: 'COD');*/
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
          decoration: BoxDecoration(
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
                _buildSummaryRow("To Pay",  "₹ ${cartProvider.cartList?.cartSummary?.totalAmount ?? ''}", isBold: true),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String title, String value,
      {bool isBold = false, bool isLink = false}) {
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
