import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWithFilterScreen extends StatefulWidget {
  const SearchWithFilterScreen({super.key});

  @override
  State<SearchWithFilterScreen> createState() => _SearchWithFilterScreenState();
}

class _SearchWithFilterScreenState extends State<SearchWithFilterScreen> {
  final TextEditingController _searchController = TextEditingController();

  /// Filter options
  final List<String> skinTypes = ["Oily", "Dry", "Combo", "Sensitive"];
  final Set<String> selectedSkinTypes = {};

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.6, // 60% of screen height
              minChildSize: 0.4,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Close Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 40), // alignment placeholder
                          Text(
                            "Filter",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      /// Scrollable Filter List
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            Text(
                              "Skin Type",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            ...skinTypes.map((type) {
                              final isSelected = selectedSkinTypes.contains(type);
                              return CheckboxListTile(
                                value: isSelected,
                                onChanged: (val) {
                                  setStateSheet(() {
                                    if (val == true) {
                                      selectedSkinTypes.add(type);
                                    } else {
                                      selectedSkinTypes.remove(type);
                                    }
                                  });
                                },
                                title: Text(type, style: TextStyle(fontSize: 14.sp)),
                                activeColor: Colors.red,
                                controlAffinity: ListTileControlAffinity.leading,
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),

                      /// Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              setStateSheet(() => selectedSkinTypes.clear());
                            },
                            child: const Text("RESET", style: TextStyle(color: Colors.grey)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: const Text("APPLY"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }


  /// Dummy New Launch Data
  final List<Map<String, String>> newLaunches = [
    {
      "image": "https://via.placeholder.com/150",
      "price": "₹699",
      "desc": "Lorem ipsum dolor sit amet.",
    },
    {
      "image": "https://via.placeholder.com/150",
      "price": "₹699",
      "desc": "Lorem ipsum dolor sit amet.",
    },
    {
      "image": "https://via.placeholder.com/150",
      "price": "₹699",
      "desc": "Lorem ipsum dolor sit amet.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Search Product",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Search any Product..",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(FeatherIcons.sliders),
                      onPressed: _openFilterSheet,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              /// Search History
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search History",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.delete, color: Colors.red),
                ],
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 8.h,
                children: ["Face", "Eyes", "Lips", "Nails", "Makeup Kits", "Tools & Brushes"]
                    .map((tag) => Chip(label: Text(tag)))
                    .toList(),
              ),

              SizedBox(height: 20.h),

              /// Search Recommendations
              Text(
                "Search Recommendations",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 8.h,
                children: ["Perfumes", "Deos", "Roll-Ons"]
                    .map((tag) => Chip(label: Text(tag)))
                    .toList(),
              ),

              SizedBox(height: 20.h),

              /// New Launches
              Text(
                "New Launches",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: newLaunches.length,
                  itemBuilder: (context, index) {
                    final item = newLaunches[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: SizedBox(
                        width: 130.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                item["image"]!,
                                height: 130.w,
                                width: 130.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              item["desc"]!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              item["price"]!,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
