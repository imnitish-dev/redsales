import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/product_detail_model.dart';




/*
class SizeSelector extends StatefulWidget {
  final List<String> sizes; // Data from parent
  final ValueChanged<String>? onSelected; // Callback when a size is selected

  const SizeSelector({
    super.key,
    required this.sizes,
    this.onSelected,
  });

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedIndex = -1; // No selection initially

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size Available",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12.h),

        /// List of sizes (Horizontal)
        Wrap(
          spacing: 12.w,
          runSpacing: 8.h,
          children: List.generate(widget.sizes.length, (index) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                if (widget.onSelected != null) {
                  widget.onSelected!(widget.sizes[index]);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red.shade50 : Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  widget.sizes[index],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.red : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}*/


class SizeSelector extends StatefulWidget {
  final List<DetailProductCustomPrice>? prices;
  final ValueChanged<String>? onSelected;

  const SizeSelector({
    super.key,
    required this.prices,
    this.onSelected,
  });

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedIndex = -1; // No selection initially

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size Available",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12.h),

        /// Display each CustomPrice as a selectable chip
        Wrap(
          spacing: 12.w,
          runSpacing: 8.h,
          children: List.generate(widget.prices!.length, (index) {
            final priceOption = widget.prices?[index];
            final isSelected = selectedIndex == index;

            // You can customize the display (e.g., show quantity/price)
            final displayText = "${priceOption?.maxQuantity ?? '-'} pcs";

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                if (widget.onSelected != null && priceOption?.customPriceId != null) {
                  widget.onSelected!(priceOption!.customPriceId!);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red.shade50 : Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.red : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
