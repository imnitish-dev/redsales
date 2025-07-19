import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/screens/home_screen/random_product_shop_now_widget.dart';
import 'package:twocliq/screens/home_screen/recommended_section_widget.dart';
import 'package:twocliq/screens/home_screen/shop_by_section_widget.dart';
import 'package:twocliq/screens/home_screen/top_brands_widget.dart';
import 'package:twocliq/screens/home_screen/top_products_widget.dart';
import '../../helper/constants.dart';
import 'announcement_widget.dart';
import 'beauty_carousel.dart';
import 'features_widget.dart';
import 'flash_sale_widget.dart';
import 'home_header_widget.dart';
import 'latest_offer_widget.dart';
import 'looking_for_inspiration_widget.dart';
import 'new_arrival_widget.dart';
import 'offers_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          HomeHeaderWidget(cartCount: 5, notificationCount: 4),
          customSizedBox(height: 6.h),
          AnnouncementWidget(),
          customSizedBox(height: 20.h),
          CategoryList(),
          customSizedBox(height: 20.h),
          BeautyCarousel(),
          customSizedBox(height: 20.h),
          RecommendationSection(),
          ShopBySectionWidget(),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
            child: DottedLine(
              dashColor: Colors.grey.withOpacity(0.4),
              dashLength: 5,
              dashGapLength: 3,
              lineThickness: 2,
            ),
          ),
          NewArrivalsSectionWidget(),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 0.h, bottom: 5.h),
            child: DottedLine(
              dashColor: Colors.grey.withOpacity(0.4),
              dashLength: 5,
              dashGapLength: 3,
              lineThickness: 2,
            ),
          ),
          TopProductsSection(),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h, bottom: 10.h),
            child: DottedLine(
              dashColor: Colors.grey.withOpacity(0.4),
              dashLength: 5,
              dashGapLength: 3,
              lineThickness: 2,
            ),
          ),
          FlashSaleSectionWidget(),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
            child: DottedLine(
              dashColor: Colors.grey.withOpacity(0.4),
              dashLength: 5,
              dashGapLength: 3,
              lineThickness: 2,
            ),
          ),
          LookingForInspirationWidget(),
          customSizedBox(height: 10.h),
          LatestOffersWidget(
            bannerImage:
                "https://imgs.littleextralove.com/wp-content/uploads/2023/04/natural-versus-chemical-skin-care-which-is-better-feat.jpg", // Replace with your image path
            title: "Latest Offers",
            subtitle: "Summer’ 25 Collections",
            onTap: () {
              // Handle navigation or click
              print("Navigate to offers");
            },
          ),
          customSizedBox(height: 10.h),
          RandomProductShopNowWidget(bannerImage: "https://www.gloskinbeauty.com/media/catalog/category/featured_header_Desktop-_brighten-glow__3.jpg"),
          customSizedBox(height: 10.h),
          TopBrandsWidget(),
          customSizedBox(height: 10.h),
          FeaturesSectionWidget()
        ],
      ),
    );
  }
}
