import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryOption {
  final String title;
  final String time;
  final String price;

  DeliveryOption({
    required this.title,
    required this.time,
    required this.price,
  });
}

class DeliverySelector extends StatefulWidget {
  final List<DeliveryOption> options;
  final Function(int) onSelected;

  const DeliverySelector({
    super.key,
    required this.options,
    required this.onSelected,
  });

  @override
  State<DeliverySelector> createState() => _DeliverySelectorState();
}

class _DeliverySelectorState extends State<DeliverySelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.options.length, (index) {
        final option = widget.options[index];
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onSelected(index);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300.withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Title + Time
                Row(
                  children: [
                    Text(
                      option.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        option.time,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                /// Price
                Text(
                  option.price,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}