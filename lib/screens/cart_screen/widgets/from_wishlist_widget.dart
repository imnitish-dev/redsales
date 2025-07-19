import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistItem {
  final String imageUrl;
  final String description;
  final String price;
  final String size;

  WishlistItem({
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.size,
  });
}

class FromWishlistWidget extends StatelessWidget {
  const FromWishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Sample Data ---
    final List<WishlistItem> wishlistItems = [
      WishlistItem(
        imageUrl: "https://picsum.photos/200/301",
        description: "Lorem ipsum dolor sit amet consectetur.",
        price: "₹699",
        size: "20 ml",
      ),
      WishlistItem(
        imageUrl: "https://picsum.photos/200/302",
        description: "Lorem ipsum dolor sit amet consectetur.",
        price: "₹699",
        size: "20 ml",
      ),
    ];

    return Padding(
      padding:  EdgeInsets.all(17.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "From Your Wishlist",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          /// Wishlist Items
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              final item = wishlistItems[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Product Image + Delete Button
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            item.imageUrl,
                            width: 120.w,
                            height: 120.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 120.w,
                              height: 120.w,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.h,
                          left: 8.w,
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            child: const Icon(Icons.delete, color: Colors.red, size: 22),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),

                    /// Description + Price + Size + Add to Cart
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
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: Colors.pink.shade50,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  item.size,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.pink.shade50,
                                ),
                                child: const Icon(Icons.add_shopping_cart, color: Colors.pink),
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
          ),
        ],
      ),
    );
  }
}
