import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Cart Item Model
class CartItem {
  final String imageUrl;
  final String description;
  final String price;

  CartItem({
    required this.imageUrl,
    required this.description,
    required this.price,
  });
}

class CartItemListWidget extends StatefulWidget {
  const CartItemListWidget({super.key});

  @override
  State<CartItemListWidget> createState() => _CartItemListWidgetState();
}

class _CartItemListWidgetState extends State<CartItemListWidget> {
  /// Sample cart items
  final List<CartItem> _cartItems = [
    CartItem(
      imageUrl: "https://picsum.photos/200/310",
      description: "Lorem ipsum dolor sit amet consectetur.",
      price: "₹699",
    ),
    CartItem(
      imageUrl: "https://picsum.photos/200/311",
      description: "Lorem ipsum dolor sit amet consectetur.",
      price: "₹699",
    ),
  ];

  /// Quantities for each cart item
  late List<int> _quantities;

  @override
  void initState() {
    super.initState();
    _quantities = List.generate(_cartItems.length, (_) => 1);
  }

  void _updateQuantity(int index, int change) {
    setState(() {
      _quantities[index] = (_quantities[index] + change).clamp(1, 99);
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
      _quantities.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _cartItems.isEmpty
        ? Center(
      child: Text(
        "No items in cart",
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    )
        : ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _cartItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Product Image with Delete
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      item.imageUrl,
                      width: 120.w,
                      height: 120.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            width: 120.w,
                            height: 120.w,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.broken_image,
                                size: 40, color: Colors.grey),
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 8.h,
                    left: 8.w,
                    child: GestureDetector(
                      onTap: () => _removeItem(index),
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child:
                        const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),

              /// Details and Quantity Controls
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      item.price,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    /// Quantity Selector
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _updateQuantity(index, -1),
                          child: Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.pink, width: 1.5),
                            ),
                            child: const Icon(Icons.remove,
                                color: Colors.pink),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            "${_quantities[index]}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: () => _updateQuantity(index, 1),
                          child: Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.pink, width: 1.5),
                            ),
                            child:
                            const Icon(Icons.add, color: Colors.pink),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
