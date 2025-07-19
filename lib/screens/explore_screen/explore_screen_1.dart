import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

class ExploreScreen1 extends StatefulWidget {
  const ExploreScreen1({super.key});

  @override
  State<ExploreScreen1> createState() => _ExploreScreen1State();
}

class _ExploreScreen1State extends State<ExploreScreen1> {
  int selectedSectionIndex = 1; // Default to "Categories"

  final List<ExploreSection> exploreSections = [
    ExploreSection(
      title: "Trending Now",
      iconUrl: "https://img.freepik.com/premium-vector/beauty-skin-care-logo-with-butterfly-symbol_667511-777.jpg",
      categories: [], // No subcategories here
    ),
    ExploreSection(
      title: "Categories",
      iconUrl: "https://img.freepik.com/premium-vector/beauty-skin-care-logo-with-butterfly-symbol_667511-777.jpg",
      categories: [
        ExploreCategory(name: "Face Products", imageUrl: "https://i.etsystatic.com/36848435/r/il/87b178/4140619499/il_fullxfull.4140619499_a2qc.jpg"),
        ExploreCategory(name: "Eyes Products", imageUrl: "https://img.freepik.com/premium-vector/luxury-skincare-logo-design-beauty-product-cosmetics-logo-template-set_456987-106.jpg"),
        ExploreCategory(name: "Lips Products", imageUrl: "https://i.etsystatic.com/36848435/r/il/87b178/4140619499/il_fullxfull.4140619499_a2qc.jpg"),
        ExploreCategory(name: "Fragrances", imageUrl: "https://img.freepik.com/premium-vector/luxury-skincare-logo-design-beauty-product-cosmetics-logo-template-set_456987-106.jpg"),
        ExploreCategory(name: "Nail Products", imageUrl: "https://i.etsystatic.com/36848435/r/il/87b178/4140619499/il_fullxfull.4140619499_a2qc.jpg"),
        ExploreCategory(name: "Hair Products", imageUrl: "https://img.freepik.com/premium-vector/luxury-skincare-logo-design-beauty-product-cosmetics-logo-template-set_456987-106.jpg"),
        ExploreCategory(name: "Intimate & Fem.", imageUrl: "https://i.etsystatic.com/36848435/r/il/87b178/4140619499/il_fullxfull.4140619499_a2qc.jpg"),
        ExploreCategory(name: "Oral Care", imageUrl: "https://i.etsystatic.com/36848435/r/il/87b178/4140619499/il_fullxfull.4140619499_a2qc.jpg"),
        ExploreCategory(name: "Face Products", imageUrl: "https://img.freepik.com/premium-vector/luxury-skincare-logo-design-beauty-product-cosmetics-logo-template-set_456987-106.jpg"),
        ExploreCategory(name: "Eyes Products", imageUrl: "https://i.etsystatic.com/36848435/r/il/87b178/4140619499/il_fullxfull.4140619499_a2qc.jpg"),
        ExploreCategory(name: "Lips Products", imageUrl: "https://img.freepik.com/premium-vector/luxury-skincare-logo-design-beauty-product-cosmetics-logo-template-set_456987-106.jpg"),
        ExploreCategory(name: "Fragrances", imageUrl: "https://i.etsystatic.com/36848435/r/il/87b178/4140619499/il_fullxfull.4140619499_a2qc.jpg"),
      ],
    ),
    ExploreSection(
      title: "Brands",
      iconUrl: "https://cdn.logojoy.com/wp-content/uploads/20200526134347/The-Ordinary-Logo-Beauty-.png",
      categories: [], // Could later have logos here
    ),
    ExploreSection(
      title: "Products",
      iconUrl: "https://cdn.logojoy.com/wp-content/uploads/20200526134347/The-Ordinary-Logo-Beauty-.png",
      categories: [],
    ),
    ExploreSection(
      title: "Recent Launch",
      iconUrl: "https://cdn.logojoy.com/wp-content/uploads/20200526134347/The-Ordinary-Logo-Beauty-.png",
      categories: [],
    ),
  ];


  @override
  Widget build(BuildContext context) {
    final section = exploreSections[selectedSectionIndex];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child:

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Explore",
                    style: customTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                 /* Row(
                    children: [
                      Icon(Icons.filter_alt_outlined, color: Colors.grey.shade700),
                      SizedBox(width: 8.w),
                      Icon(Icons.search, color: Colors.grey.shade700),
                    ],
                  )*/
                ],
              ),
              SizedBox(height: 20.h),

              Expanded(
                child: Row(
                  children: [
                    /// Left Menu (with Dotted Divider on Right)
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 100.w,
                            color: Colors.white,
                            child: ListView.builder(
                              itemCount: exploreSections.length,
                              itemBuilder: (context, index) {
                                final isSelected = index == selectedSectionIndex;
                                return GestureDetector(
                                  onTap: () => setState(() => selectedSectionIndex = index),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.pink.shade50 : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(6.r),
                                          child: Image.network(
                                            exploreSections[index].iconUrl,
                                            width: 40.w,
                                            height: 40.w,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => Container(
                                              width: 40.w,
                                              height: 40.w,
                                              color: Colors.grey.shade200,
                                              child: const Icon(Icons.broken_image, color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          exploreSections[index].title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: isSelected ? Colors.pink : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        /// Dotted Vertical Divider
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16.h), // Adds space on top & bottom
                    padding: EdgeInsets.only(left: 5.w,), // Space on left/right
                    child: DottedLine(
                      direction: Axis.vertical,
                      lineThickness: 1,
                      dashLength: 6,
                      dashGapLength: 4,
                      dashColor: Colors.grey.shade400,
                      lineLength: double.infinity, // Still fills remaining space inside Container
                    ),
                  ),
                )

                ],
                    ),

                    SizedBox(width: 12.w),

                    /// Right Grid (Unchanged)
                    Expanded(
                      child: section.categories.isEmpty
                          ? Center(
                        child: Text(
                          "No categories available",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                          : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: section.categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final category = section.categories[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.network(
                                    category.imageUrl,
                                    width: 100.w,
                                    height: 100.w,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100.w,
                                        height: 100.w,
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  category.name,
                                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )


             /* Expanded(
                child: Row(
                  children: [
                    /// Left Menu
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        border: Border(right: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: ListView.builder(
                        itemCount: exploreSections.length,
                        itemBuilder: (context, index) {
                          final isSelected = index == selectedSectionIndex;
                          return GestureDetector(
                            onTap: () => setState(() => selectedSectionIndex = index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.pink.shade50 : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.r),
                                    child: Image.network(
                                      exploreSections[index].iconUrl,
                                      width: 40.w,
                                      height: 40.w,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        width: 40.w,
                                        height: 40.w,
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.broken_image, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    exploreSections[index].title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Colors.pink : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(width: 12.w),

                    /// Right Grid (scrollable independently)
                    Expanded(
                      child: section.categories.isEmpty
                          ? Center(
                        child: Text(
                          "No categories available",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                          : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: section.categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final category = section.categories[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.network(
                                    category.imageUrl,
                                    width: 100.w,
                                    height: 100.w,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100.w,
                                        height: 100.w,
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  category.name,
                                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),*/
            ],
          )

        ),
      ),
    );
  }
}


class ExploreSection {
  final String title;
  final String iconUrl;
  final List<ExploreCategory> categories;

  ExploreSection({
    required this.title,
    required this.iconUrl,
    required this.categories,
  });
}

class ExploreCategory {
  final String name;
  final String imageUrl;

  ExploreCategory({
    required this.name,
    required this.imageUrl,
  });
}

