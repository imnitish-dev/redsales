import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twocliq/screens/home_screen/random_product_shop_now_widget.dart';
import 'package:twocliq/screens/home_screen/recommended_section_widget.dart';
import 'package:twocliq/screens/home_screen/shop_by_section_widget.dart';
import 'package:twocliq/screens/home_screen/top_brands_widget.dart';
import 'package:twocliq/screens/home_screen/top_products_widget.dart';
import '../../helper/constants.dart';
import '../../models/home_screen/home_screen_enums.dart';
import '../../models/home_screen/home_screen_model.dart';
import '../../provider/home_provider.dart';
import 'announcement_widget.dart';
import 'beauty_carousel.dart';
import 'features_widget.dart';
import 'flash_sale_widget.dart';
import 'home_header_widget.dart';
import 'latest_offer_widget.dart';
import 'looking_for_inspiration_widget.dart';
import 'new_arrival_widget.dart';
import 'product_icons_horizontal_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  Widget _buildSection(HomeSection section) {
    switch (section.viewType) {
      /*case ViewType.banners:
        final banners = section.displayData.cast<BannerItem>();
        return BannerCarousel(banners: banners);*/
      case ViewType.gridBanners:
        final banners = section.displayData.cast<BannerItem>();
        return SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: banners.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  banners[index].imageUrl,
                  fit: BoxFit.cover,
                  width: 300,
                ),
              );
            },
          ),
        );

     /* case ViewType.icons:
        final brands = section.displayData.cast<BannerItem>();
        return ProductIconsHorizontalList(
          brands: brands,
          //title: section.displayTitle, // Optional
        );*/


    /*case ViewType.icons:
        final brands = section.displayData.cast<BrandItem>();
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final brand = brands[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.network(
                    brand.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 4),
                Text(brand.displayText, style: const TextStyle(fontSize: 12)),
              ],
            );
          },
        );*/

      case ViewType.productList:
        final products = section.displayData.cast<ProductItem>();
        return Column(
          children: products.map((p) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(p.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              ),
              title: Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text("₹${p.sellingPrice}"),
            );
          }).toList(),
        );

      case ViewType.unknown:
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          switch (provider.status) {
            case ApiLoadingState.loading:
              return buildLoadingShimmer();

            case ApiLoadingState.error:
              return Center(
                child: Text(provider.errorMessage ?? "Failed to load",
                    style: const TextStyle(color: Colors.red)),
              );

            case ApiLoadingState.success:
              final homeData = provider.homeResponse!;
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [



                  HomeHeaderWidget(cartCount: 5, notificationCount: 4),


                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    //padding: const EdgeInsets.all(16),
                    itemCount: homeData.home.length,
                    itemBuilder: (context, index) {
                      final section = homeData.home[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (section.displayTitle.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                section.displayTitle + section.viewType.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          _buildSection(section),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 6),
                  AnnouncementWidget(),
                  const SizedBox(height: 20),


                  // Rest of your static sections
                 // CategoryList(),
                  BeautyCarousel(),
                  RecommendationSection(),
                  ShopByCategoryWidget(),
                  FlashSaleSectionWidget(),
                  TopBrandsWidget(),
                  FeaturesSectionWidget(),
                ],
              );
          }
        },
      ),
    );
  }


/*  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
         *//* ChangeNotifierProvider(
            create: (_) => HomeProvider()..loadHomeData(),
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) {
                switch (provider.status) {
                  case HomeStatus.loading:
                    return buildLoadingShimmer();

                  case HomeStatus.error:
                    return Center(
                      child: Text(
                        provider.errorMessage ?? "Failed to load",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );

                  case HomeStatus.success:
                    final homeData = provider.homeResponse!;
                    return ListView.builder(
                      itemCount: homeData.home.length,
                      itemBuilder: (context, index) {
                        final section = homeData.home[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(section.displayTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                          ],
                        );
                      },
                    );
                }
              },
            ),
          ),*//*
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
          RandomProductShopNowWidget(
              bannerImage:
                  "https://www.gloskinbeauty.com/media/catalog/category/featured_header_Desktop-_brighten-glow__3.jpg"),
          customSizedBox(height: 10.h),
          TopBrandsWidget(),
          customSizedBox(height: 10.h),
          FeaturesSectionWidget()
        ],
      ),
    );
  }*/

  Widget buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox.expand(
        // Fill the whole screen
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: List.generate(6, (index) {
              // Repeat placeholders
              return Container(
                height: index == 0 ? 180 : 100, // First banner bigger
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
