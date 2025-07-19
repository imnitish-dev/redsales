import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// MODEL FOR MAIN CATEGORY
class ShopCategory {
  final String imageUrl;
  final String label;

  ShopCategory({required this.imageUrl, required this.label});
}

/// MODEL FOR SUBCATEGORY
class SubCategory {
  final String name;

  SubCategory({required this.name});
}

/// MODEL FOR BRAND LOGO
class Brand {
  final String logoUrl;

  Brand({required this.logoUrl});
}

class ShopByScreen extends StatefulWidget {
  const ShopByScreen({super.key});

  @override
  State<ShopByScreen> createState() => _ShopByScreenState();
}

class _ShopByScreenState extends State<ShopByScreen> {
  /// Dummy data for the screen
  final List<ShopCategory> categories = [
    ShopCategory(imageUrl: "https://picsum.photos/100", label: "CATEGORIES"),
    ShopCategory(imageUrl: "https://picsum.photos/101", label: "BRANDS"),
    ShopCategory(imageUrl: "https://picsum.photos/102", label: "MAKEUP"),
    ShopCategory(imageUrl: "https://picsum.photos/103", label: "LUXE"),
    ShopCategory(imageUrl: "https://picsum.photos/104", label: "NEW LAUNCH"),
  ];

  final List<SubCategory> subCategories = [
    SubCategory(name: "Face"),
    SubCategory(name: "Lips"),
    SubCategory(name: "Hair"),
    SubCategory(name: "Nails"),
    SubCategory(name: "Eyes"),
  ];

  final List<Brand> allBrands = List.generate(
    20,
        (index) => Brand(logoUrl: "https://picsum.photos/id/${index + 200}/120"),
  );

  int selectedSubCategory = 1;

  /// To control pagination (simulate "Load More")
  int visibleBrandsCount = 9;

  @override
  Widget build(BuildContext context) {
    final visibleBrands = allBrands.take(visibleBrandsCount).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      FeatherIcons.chevronLeft,
                      size: 28.r,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Shop By",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            /// Horizontal main categories
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            category.imageUrl,
                            width: 60.w,
                            height: 60.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60.w,
                                height: 60.w,
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 28.r,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          category.label,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: index == 1
                                ? Colors.pink
                                : Colors.black.withOpacity(0.7),
                            fontWeight: index == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),

            /// Sub-categories (chips)
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: subCategories.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedSubCategory == index;
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedSubCategory = index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                              color: isSelected ? Colors.pink : Colors.grey.withOpacity(0.2)),
                        ),
                        child: Text(
                          subCategories[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: isSelected ? Colors.pink : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),

            /// Grid of Brands
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 1,
                ),
                itemCount: visibleBrands.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        visibleBrands[index].logoUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 30.r,
                            ),
                          );
                        },
                      )
                      ,
                    ),
                  );
                },
              ),
            ),

            /// Bottom "Load More" button
            if (visibleBrandsCount < allBrands.length)
              Padding(
                padding: EdgeInsets.all(16.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        visibleBrandsCount =
                            (visibleBrandsCount + 6).clamp(0, allBrands.length);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Load More Brands",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
