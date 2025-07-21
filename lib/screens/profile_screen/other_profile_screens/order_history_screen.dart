import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

/*
class Order {
  final String imageUrl;
  final String orderId;
  final String status;
  final int itemsCount;

  Order({
    required this.imageUrl,
    required this.orderId,
    required this.status,
    required this.itemsCount,
  });
}

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({super.key});

  final List<Order> orders = [
    Order(imageUrl: "https://picsum.photos/200/300", orderId: "#92287157", status: "Packed", itemsCount: 3),
    Order(imageUrl: "https://picsum.photos/200/301", orderId: "#92287157", status: "Shipped", itemsCount: 4),
    Order(imageUrl: "https://picsum.photos/200/302", orderId: "#92287157", status: "Packed", itemsCount: 4),
    Order(imageUrl: "https://picsum.photos/200/303", orderId: "#92287157", status: "Shipped", itemsCount: 4),
    Order(imageUrl: "https://picsum.photos/200/304", orderId: "#92287157", status: "Delivered", itemsCount: 5),
    Order(imageUrl: "https://picsum.photos/200/300", orderId: "#92287157", status: "Packed", itemsCount: 3),
    Order(imageUrl: "https://picsum.photos/200/301", orderId: "#92287157", status: "Shipped", itemsCount: 4),
    Order(imageUrl: "https://picsum.photos/200/302", orderId: "#92287157", status: "Packed", itemsCount: 4),
    Order(imageUrl: "https://picsum.photos/200/303", orderId: "#92287157", status: "Shipped", itemsCount: 4),
    Order(imageUrl: "https://picsum.photos/200/304", orderId: "#92287157", status: "Delivered", itemsCount: 5),
    Order(imageUrl: "https://picsum.photos/200/300", orderId: "#92287157", status: "Packed", itemsCount: 3),
    Order(imageUrl: "https://picsum.photos/200/301", orderId: "#92287157", status: "Shipped", itemsCount: 4),
    Order(imageUrl: "https://picsum.photos/200/302", orderId: "#92287157", status: "Packed", itemsCount: 4),
    Order(imageUrl: "https://picsum.photos/200/303", orderId: "#92287157", status: "Shipped", itemsCount: 4),
    Order(imageUrl: "https://picsum.photos/200/304", orderId: "#92287157", status: "Delivered", itemsCount: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            customSizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Order History",
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            customSizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
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

  Widget _buildOrderCard(Order order) {
    return Padding(
      padding:  EdgeInsets.all(10.r),
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
          child:

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(order.imageUrl, width: 60.w, height: 60.w, fit: BoxFit.cover),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order ${order.orderId}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  const Text("Standard Delivery", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(order.status,
                          style: TextStyle(
                            color: order.status == "Delivered" ? Colors.green : Colors.black,
                            fontWeight: FontWeight.w500,
                          )),
                      if (order.status == "Delivered")
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: const Icon(Icons.check_circle, color: Colors.green, size: 16),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 8.w),

              Column(
                children: [

                  if (order.itemsCount != null)
                    Text(
                      "${order.itemsCount} items",
                      style: customTextStyle(fontSize: 14.sp, color: Colors.black),
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
                              borderRadius: BorderRadius.circular(20.r)),
                        ),
                        onPressed: () {},
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
                              borderRadius: BorderRadius.circular(20.r)),
                        ),
                        onPressed: () {},
                        child: const Text("Track"),
                      ),
                    )
                ],
              )


            ],
          )),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/models/order_model.dart';
import '../../../provider/home_provider.dart';
import '../../../provider/orders_provider.dart';


class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orders = ordersProvider.orders ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            customSizedBox(height: 10.h),
            Center(
              child: Text(
                "Order History",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            customSizedBox(height: 10.h),

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
    final imageUrl = (order.products!.isNotEmpty ? order.products?.first.imageUrl : null) ?? '';

    return Padding(
      padding: EdgeInsets.all(10.r),
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
            // Product Image with onError fallback
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  const Text("Standard Delivery", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        (order.logs != null && order.logs!.isNotEmpty)
                            ? order.logs!.first.logType ?? ""
                            : "", // Show empty string if no logs
                        style: TextStyle(
                          color: order.status == "Delivered" ? Colors.green : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (order.status == "Delivered")
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: const Icon(Icons.check_circle, color: Colors.green, size: 16),
                        ),
                    ],
                  ),
                /*  Row(
                    children: [
                      Text(order.logs?[0].logType??"",
                          style: TextStyle(
                            color: order.status == "Delivered" ? Colors.green : Colors.black,
                            fontWeight: FontWeight.w500,
                          )),
                      if (order.status == "Delivered")
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: const Icon(Icons.check_circle, color: Colors.green, size: 16),
                        ),
                    ],
                  ),*/
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // Right-side Actions
            Column(
              children: [
                Text(
                  "${order.products?.fold<int>(0, (sum, p) => sum + (p.quantity ?? 0))} items",
                  style: customTextStyle(fontSize: 14.sp, color: Colors.black),
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
                        // Add Review logic here
                      },
                      child: const Text("Review", style: TextStyle(color: Colors.pink)),
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
    );
  }
}
