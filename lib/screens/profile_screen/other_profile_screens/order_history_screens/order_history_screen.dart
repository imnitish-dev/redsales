import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/models/order_model.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/order_history_screens/order_summary_screen.dart';
import '../../../../helper/animatedPage.dart';
import '../../../../provider/home_provider.dart';
import '../../../../provider/orders_provider.dart';
import '../../../search_screen.dart';


class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orders = ordersProvider.orders ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            customSizedBox(height: 20.h),
            Center(
              child: Text(
                "Order History",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            customSizedBox(height: 5.h),

            // Handle loading/error states
            if (ordersProvider.status == ApiLoadingState.loading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (ordersProvider.status == ApiLoadingState.error)
              Expanded(
                child: Center(
                  child: Text(
                    ordersProvider.errorMessage ?? "Failed to load orders",
                    style: TextStyle(color: Colors.red, fontSize: 16.sp),
                  ),
                ),
              )
            else if (orders.isEmpty)
                const Expanded(
                  child: Center(child: Text("No orders found")),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return _buildOrderCard(order);
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    // Get first product image (fallback if no products)
    final imageUrl = (order.products != null && order.products!.isNotEmpty
        ? order.products!.first.imageUrl
        : '') ?? '';

    return Padding(
      padding: EdgeInsets.all(10.r),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(openAnimatedPage(
            OrderSummaryScreen(order: order)
          ));
        },
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Product Image with fallback
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  imageUrl,
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60.w,
                      height: 60.w,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),
              SizedBox(width: 10.w),

              // Order Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order ${order.orderId}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    //const Text("Standard Delivery", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 4.h),
                    Text(OrderModel().getLatestLogType(order.logs) ?? '',style: customTextStyle(fontSize: 14.sp)),

                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // Right-side actions
              Column(
                children: [
                  Text(
                    "${order.products?.fold<int>(
                      0,
                          (sum, p) => sum + (p.quantity ?? 0),
                    )} items",
                    style: customTextStyle(
                        fontSize: 14.sp, color: Colors.black),
                  ),
                  customSizedBox(height: 6.h),
                  if (order.status == "Delivered")
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.pink),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        onPressed: () {
                          // Add review logic here
                        },
                        child: const Text("Review",
                            style: TextStyle(color: Colors.pink)),
                      ),
                    )
                  else
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        onPressed: () {
                          // Track order logic
                        },
                        child: const Text("Track"),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

