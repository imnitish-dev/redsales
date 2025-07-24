import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/order_history_screens/track_order_screen.dart';
import 'package:intl/intl.dart';
import '../../../../helper/animatedPage.dart';
import '../../../../models/order_model.dart';

class OrderSummaryScreen extends StatelessWidget {
  final OrderModel order;
  const OrderSummaryScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final delivery = order.deliveryAddress;
    final payment = order.paymentSummary;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /*    IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(FeatherIcons.chevronLeft,size: 25.r)),*/
                  Padding(
                    padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 2.w),
                    child: Text(
                      "Order Summary",
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        
              //_sectionTitle("Order Info"),
              Row(
                children: [
                  Icon(FeatherIcons.alignLeft, size: 20.r),
                  customSizedBox(width: 10.w),
                  _sectionTitle("Order Info"),
                ],
              ),
              _infoRow("Order ID", order.orderId ?? "N/A"),
              _infoRow("Status", OrderModel().getLatestLogType(order.logs) ?? 'N/A'),
              _infoRow("Placed On", _formatTimestamp(order.orderDate?.timestamp)),
        
              customSizedBox(height: 15.h),
              DottedLine(
                dashColor: Colors.grey.withOpacity(0.25),
                dashLength: 5,
                dashGapLength: 3,
                lineThickness: 2,
              ),
              customSizedBox(height: 15.h),
        
              // _sectionTitle("Delivery Address"),
        
              Row(
                children: [
                  Icon(FeatherIcons.mapPin, size: 20.r),
                  customSizedBox(width: 10.w),
                  _sectionTitle("Delivery Address"),
                ],
              ),
        
              _infoRow("Address", "${delivery?.address}, ${delivery?.area}, ${delivery?.city} - ${delivery?.pincode}"),
              _infoRow("Landmark", delivery?.landmark ?? ""),
              _infoRow("Pin Code", delivery?.pincode ?? ""),
              _infoRow("City/Town", delivery?.city ?? ""),
              _infoRow("State", delivery?.state ?? ""),
        
              customSizedBox(height: 15.h),
              DottedLine(
                dashColor: Colors.grey.withOpacity(0.25),
                dashLength: 5,
                dashGapLength: 3,
                lineThickness: 2,
              ),
              customSizedBox(height: 15.h),
        
              Row(
                children: [
                  Icon(FeatherIcons.clipboard, size: 20.r),
                  customSizedBox(width: 10.w),
                  _sectionTitle("Products"),
                ],
              ),
              ...order.products!.map((product) =>
        
                  /*  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            product.imageUrl ?? '',
                            height: 50,
                            width: 50,
                            errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(product.productTitle ?? "",textAlign: TextAlign.end),
                                Row(
                                  children: [
                                    Text("${product.quantity} x ₹${product.sellingPrice}"),
                                    Text("₹${(product.quantity ?? 0) * (product.sellingPrice ?? 0)}")
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )*/
        
                  /*ListTile(
                    leading: Image.network(
                      product.imageUrl ?? '',
                      height: 50.r,
                      width: 50.r,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                    ),
                    title: Text(product.productTitle ?? "", style: customTextStyle(fontSize: 14.sp),maxLines: 2,overflow: TextOverflow.ellipsis),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${product.quantity} x ₹${product.sellingPrice}"),
                    ),
                    trailing: Text("₹${(product.quantity ?? 0) * (product.sellingPrice ?? 0)}"),
                  )*/
        
              Padding(
                padding:  EdgeInsets.all(12.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Image.network(
                        product.imageUrl?? '',
                        height: 60.r,
                        width: 60.r,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 60.r,
                          width: 60.r,
                          color: Colors.grey.shade200,
                          alignment: Alignment.center,
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
        
                    // Title, Quantity & Price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productTitle ?? "",
                            style: customTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${product.quantity ?? 0} x ₹${product.sellingPrice ?? 0}",
                            style: customTextStyle(fontSize: 14.sp, color: Colors.grey.shade900),
                          ),
                        ],
                      ),
                    ),
        
                    // Total Amount (on right)
                    Padding(
                      padding:  EdgeInsets.only(left: 5.w),
                      child: Text(
                        "₹ ${(product.quantity ?? 0) * (product.sellingPrice ?? 0)}",
                        style: customTextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
        
              ),
        
              customSizedBox(height: 15.h),
              DottedLine(
                dashColor: Colors.grey.withOpacity(0.25),
                dashLength: 5,
                dashGapLength: 3,
                lineThickness: 2,
              ),
              customSizedBox(height: 15.h),
        
              _sectionTitle("Payment Summary"),
              _infoRow("Item Amount", "₹${payment?.itemAmount ?? 0}"),
              _infoRow("Tax", "₹${payment?.taxAmount ?? 0}"),
              _infoRow("Shipping", "₹${payment?.shippingAmount ?? 0}"),
              _infoRow("Wallet Used", "-₹${payment?.walletUsed ?? 0}"),
              _infoRow("Total Paid", "₹${payment?.otherPaymentAmount ?? 0}", bold: true),
              _infoRow("Payment Mode", payment?.paymentMode ?? "N/A"),

              customSizedBox(height: 20.h),

              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(openAnimatedPage(
                        TrackOrderScreen(order: order)
                    ));
                  },
                  child: Text(
                    "Track Order",
                    style: customTextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  String formatDate(int? timestamp) {
    if (timestamp == null) return '';

    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Get day with ordinal suffix (st, nd, rd, th)
    String day = dateTime.day.toString();
    String suffix = 'th';
    if (!(day.endsWith('11') || day.endsWith('12') || day.endsWith('13'))) {
      if (day.endsWith('1')) suffix = 'st';
      else if (day.endsWith('2')) suffix = 'nd';
      else if (day.endsWith('3')) suffix = 'rd';
    }

    final monthYear = DateFormat('MMMM yyyy').format(dateTime); // e.g. "July 2023"
    final time = DateFormat('h:mm a').format(dateTime); // e.g. "6:59 AM"

    return '$day$suffix $monthYear, $time';
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
    );
  }

  Widget _infoRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: customTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 60.w),
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: customTextStyle(
                  fontSize: 14.sp,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(int? ts) {
    if (ts == null) return "N/A";
    final date = DateTime.fromMillisecondsSinceEpoch(ts);
    return "${date.day}/${date.month}/${date.year}";
  }
}
