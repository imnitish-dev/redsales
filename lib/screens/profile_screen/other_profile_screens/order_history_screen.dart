import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

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
