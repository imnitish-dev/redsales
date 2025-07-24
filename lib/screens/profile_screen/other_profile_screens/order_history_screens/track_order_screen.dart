import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../helper/constants.dart';
import '../../../../models/order_model.dart';
import '../../../../widgets/three_step_progress_bar.dart';

class TrackOrderScreen extends StatefulWidget {
  final OrderModel order;
  const TrackOrderScreen({super.key, required this.order});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {

  final List<LogEntry> fakeLogs = [
    LogEntry(
      logType: "ORDER_PLACED",
      logDate: OrderDate(timestamp: DateTime(2025, 4, 19, 10, 15).millisecondsSinceEpoch),
      logUser: LogUser(userId: "1", name: "Customer"),
    ),
    LogEntry(
      logType: "PAYMENT_CONFIRMED",
      logDate: OrderDate(timestamp: DateTime(2025, 4, 19, 12, 30).millisecondsSinceEpoch),
      logUser: LogUser(userId: "2", name: "System"),
    ),
    LogEntry(
      logType: "PACKED",
      logDate: OrderDate(timestamp: DateTime(2025, 4, 19, 15, 45).millisecondsSinceEpoch),
      logUser: LogUser(userId: "3", name: "Warehouse"),
    ),
    LogEntry(
      logType: "SHIPPED",
      logDate: OrderDate(timestamp: DateTime(2025, 4, 19, 18, 20).millisecondsSinceEpoch),
      logUser: LogUser(userId: "4", name: "Courier"),
    ),
    LogEntry(
      logType: "OUT_FOR_DELIVERY",
      logDate: OrderDate(timestamp: DateTime(2025, 4, 20, 8, 10).millisecondsSinceEpoch),
      logUser: LogUser(userId: "5", name: "Courier"),
    ),
    LogEntry(
      logType: "ORDER_MARKED_RECEIVED",
      logDate: OrderDate(timestamp: DateTime(2025, 4, 20, 13, 50).millisecondsSinceEpoch),
      logUser: LogUser(userId: "1", name: "Customer"),
    ),
  ];

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


  @override
  Widget build(BuildContext context) {
    final currentStep = OrderModel().getLatestLogStep(widget.order.logs) ?? 1;
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
                  Padding(
                    padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 2.w),
                    child: Text(
                      "Track Order",
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

             /* Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 20.h,bottom: 20.h ),
                    child: StepProgressBar(currentStep: currentStep ),
                  ),
                ],
              ),



              customSizedBox(height: 15.h),
              DottedLine(
                dashColor: Colors.grey.withOpacity(0.25),
                dashLength: 5,
                dashGapLength: 3,
                lineThickness: 2,
              ),
              customSizedBox(height: 15.h),*/

              TrackingNumberWidget(),

              customSizedBox(height: 15.h),
              DottedLine(
                dashColor: Colors.grey.withOpacity(0.25),
                dashLength: 5,
                dashGapLength: 3,
                lineThickness: 2,
              ),
              customSizedBox(height: 15.h),
             // buildLogTimeline(widget.order.logs!),

              if(widget.order.logs!=null)
                buildLogTimeline(widget.order.logs!),

             // buildLogTimeline(fakeLogs)


            ],
          ),
        ),
      ),
    );
  }

  Widget TrackingNumberWidget(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.redAccent.withOpacity(0.1)
      ),
      child: Padding(
        padding:  EdgeInsets.all(15.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tracking Number", style: customTextStyle(color: Colors.black,fontSize: 17.sp,fontWeight: FontWeight.w500)),
                customSizedBox(height: 5.h),
                Text(widget.order.orderId??"", style: customTextStyle(fontWeight: FontWeight.w300,fontSize: 15.sp))
              ],
            ),
            Icon(FeatherIcons.truck,size: 25.r,color: Colors.redAccent,)
          ],
        ),
      ),
    );
  }

  Widget buildLogTimeline(List<LogEntry> logs) {
    // Sort logs by timestamp ascending (oldest first)
    logs.sort((a, b) {
      final tsA = a.logDate?.timestamp ?? 0;
      final tsB = b.logDate?.timestamp ?? 0;
      return tsA.compareTo(tsB);
    });

    String getReadableLogType(String? logType) {
      switch (logType) {
        case "ORDER_PLACED":
          return "Order Placed";
        case "ORDER_MARKED_RECEIVED":
          return "Order Received";
        default:
          return logType ?? "";
      }
    }

    String getSubtitle(String? logType) {
      switch (logType) {
        case "ORDER_PLACED":
          return "Your order has been confirmed and is being prepared.";
        case "ORDER_MARKED_RECEIVED":
          return "Your order was delivered and confirmed as received.";
        default:
          return "";
      }
    }

    return Column(
      children: List.generate(logs.length, (index) {
        final log = logs[index];
        final isLast = index == logs.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circle + vertical line
              Column(
                children: [
                  // Align circle *exactly* to the title baseline
                  Container(
                    margin: const EdgeInsets.only(top: 4), // fine-tune
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: Colors.pink.shade200,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // Text content (title + subtitle + timestamp)
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getReadableLogType(log.logType),
                        style: customTextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      if (getSubtitle(log.logType).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            getSubtitle(log.logType),
                            style: customTextStyle(
                                fontSize: 13.sp, color: Colors.black),
                          ),
                        ),
                      const SizedBox(height: 6),
                      Text(
                        formatDate(log.logDate?.timestamp),
                        style: customTextStyle(
                            fontSize: 12.sp, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }


 /* Widget buildLogTimeline(List<LogEntry> logs) {
    // Sort logs by timestamp ascending (oldest first)
    logs.sort((a, b) {
      final tsA = a.logDate?.timestamp ?? 0;
      final tsB = b.logDate?.timestamp ?? 0;
      return tsA.compareTo(tsB);
    });

    String getReadableLogType(String? logType) {
      switch (logType) {
        case "ORDER_PLACED":
          return "Order Placed";
        case "ORDER_MARKED_RECEIVED":
          return "Order Received";
        default:
          return logType ?? "";
      }
    }

    return Column(
      children: List.generate(logs.length, (index) {
        final log = logs[index];
        final isLast = index == logs.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline circle + dynamic connector
              Column(
                children: [
                  SizedBox(
                    height: 20, // Match roughly the title's line height
                    child: Align(
                      alignment: Alignment.center, // Vertically centers to the title
                      child: Container(
                        width: 16.r,
                        height: 16.r,
                        decoration: const BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: Colors.pink.shade200,
                      ),
                    ),
                ],
              ),
              customSizedBox(width: 12),
              // Log details (title + optional subtitle + date)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              getReadableLogType(log.logType),
                              style: customTextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      if (log.logType == "ORDER_PLACED")
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            "Your order has been confirmed and is being prepared.",
                            style: customTextStyle(
                                fontSize: 13.sp, color: Colors.black),
                          ),
                        )
                      else if (log.logType == "ORDER_MARKED_RECEIVED")
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            "Your order was delivered and confirmed as received.",
                            style: customTextStyle(
                                fontSize: 13.sp, color: Colors.black),
                          ),
                        ),
                      SizedBox(height: 6.h),
                      Text(
                        formatDate(log.logDate?.timestamp),
                        style: customTextStyle(
                            fontSize: 12.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );




    return Column(
      children: List.generate(logs.length, (index) {
        final log = logs[index];
        final isLast = index == logs.length - 1;

        return IntrinsicHeight( // Ensures both circle/line and text stretch together
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline circle + dynamic connector line
              Column(
                children: [
                  Container(
                    width: 16.r,
                    height: 16.r,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: Colors.pink.shade200,
                      ),
                    ),
                ],
              ),
              customSizedBox(width: 12),
              // Log details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getReadableLogType(log.logType),
                        style: customTextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      customSizedBox(height: 4.h),
                      if (log.logType == "ORDER_PLACED")
                        Text(
                          "Your order has been confirmed and is being prepared.",
                          style: customTextStyle(
                              fontSize: 13.sp, color: Colors.black),
                        )
                      else if (log.logType == "OUT_FOR_DELIVERY")
                        Text(
                          "Your order has been confirmed and is being prepared.",
                          style: customTextStyle(
                              fontSize: 13.sp, color: Colors.black),
                        )
                      else if (log.logType == "ORDER_MARKED_RECEIVED")
                        Text(
                          "Your order was delivered and confirmed as received.",
                          style: customTextStyle(
                              fontSize: 13.sp, color: Colors.black),
                        ),
                      customSizedBox(height: 6.h),
                      Text(
                        formatDate(log.logDate?.timestamp),
                        style: customTextStyle(
                            fontSize: 12.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );

  }*/


}
