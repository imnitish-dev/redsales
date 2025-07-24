import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twocliq/models/home_screen/seperated_models/horizontal_banner_model.dart';
import 'package:twocliq/models/home_screen/seperated_models/horizontal_icon_model.dart';
import 'package:twocliq/models/home_screen/seperated_models/shop_by_category_model.dart';
import 'package:twocliq/models/home_screen/seperated_models/top_product_model.dart';
import 'package:twocliq/screens/home_screen/recommended_section_widget.dart';
import 'package:twocliq/screens/home_screen/shop_by_section_widget.dart';
import 'package:twocliq/screens/home_screen/top_products_widget.dart';
import '../../models/home_screen/home_screen_enums.dart';
import '../../models/home_screen/home_screen_model.dart';
import '../../models/home_screen/seperated_models/announcement_model.dart';
import '../../models/home_screen/seperated_models/recommended_product_item_model.dart';
import '../../provider/home_provider.dart';
import '../widgets/shimmer_widget.dart';
import 'announcement_widget.dart';
import 'beauty_carousel.dart';
import 'features_widget.dart';
import 'home_header_widget.dart';
import 'product_icons_horizontal_list.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {



  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        switch (provider.status) {
          case ApiLoadingState.loading:
            return buildLoadingShimmer();

          case ApiLoadingState.error:
            return Center(
              child: Text(
                provider.errorMessage ?? "Failed to load",
                style: const TextStyle(color: Colors.red),
              ),
            );

          case ApiLoadingState.success:
            final homeData = provider.homeResponse!;

            return Column(
              children: [
                const HomeHeaderWidget(cartCount: 5, notificationCount: 4),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          //padding: const EdgeInsets.all(16),
                          itemCount: homeData.home.length,
                          itemBuilder: (context, index) {
                            final section = homeData.home[index];
                            return Padding(
                              padding:  EdgeInsets.only(top: 5.h,bottom: 5.h),
                              child: Column(
                                children: [
                                  _buildSection(section),
                                ],
                              ),
                            );
                          },
                        ),
                        FeaturesSectionWidget()
                      ],
                    ),
                  ),
                ),


              ],
            );
        }
      },
    );
  }

  Widget _buildSection(HomeSection section) {
    switch (section.viewType) {


    /// Announcement section (horizontal scroll of text)
      case ViewType.announcement:
        final announcements = section.displayData.cast<AnnouncementItem>();
        return AnnouncementCarousel(
          announcements: announcements,
        );

    /// Horizontal icons (like categories row)
      case ViewType.horizontalIcons:
        final icons = section.displayData.cast<HorizontalIconModel>();
        return ProductIconsHorizontalList(brands: icons);

      /// Horizontal banners and grid banners (carousel style)
      case ViewType.banners:
        final banners = section.displayData.cast<HorizontalBannerModel>();
        return BannerCarousel(banners: banners);


    /// Shop by categories (grid style)
      case ViewType.shopByCategories:
        final categories = section.displayData.cast<ShopByCategoryModel>();
        return ShopBySectionWidget2(title: "hehe", shopItems: categories);

      case ViewType.recommendedProducts:
        final recommendedProducts = section.displayData.cast<RecommendedCategoryModel>();
        return RecommendationSection2(categories: recommendedProducts);

    /// Top products (horizontal scroll of image cards)
      case ViewType.topProducts:
        final topProducts = section.displayData.cast<TopProductModel>();
        return TopProductsSection2(topProducts: topProducts);

    /// Vertical banners (stack with optional text overlay)
      case ViewType.verticalBanners:
        final banners = section.displayData.cast<VerticalBannerItem>();
        return Padding(
          padding: EdgeInsets.all(12.r),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Banner Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        banner.imageUrl ?? '',
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 180,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),

                    /// Display text below image (if any)
                    if (banner.displayText != null || banner.displayText2 != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (banner.displayText != null)
                              Text(
                                banner.displayText!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            if (banner.displayText2 != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  banner.displayText2!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );








      case ViewType.gridBanners:
      //todo: disabling other ViewTypes
        return const SizedBox();
        final banners = section.displayData.cast<BannerItem>();
        return SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: banners.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  banner.imageUrl,
                  fit: BoxFit.cover,
                  width: 300,
                  errorBuilder: (_, __, ___) => Container(
                    width: 300,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              );
            },
          ),
        );






      /// Old ICONS view (grid)
      case ViewType.icons:
      //todo: disabling other ViewTypes
        return const SizedBox();
        final brands = section.displayData.cast<BrandItem>();
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
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
                    errorBuilder: (_, __, ___) => Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(brand.displayText, style: const TextStyle(fontSize: 12)),
              ],
            );
          },
        );

      /// Product list
      case ViewType.productList:
      //todo: disabling other ViewTypes
        return const SizedBox();
        final products = section.displayData.cast<ProductItem>();
        return Column(
          children: products.map((p) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  p.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
              title: Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text("₹${p.sellingPrice}"),
            );
          }).toList(),
        );

      case ViewType.unknown:
        return const SizedBox();
    }
  }

/*  Widget buildLoadingShimmer() {
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

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
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
                    _buildSection(section),
                  ],
                );
              },
            );
        }
      },
    );
  }

  Widget _buildSection(HomeSection section) {
    switch (section.viewType) {
      case ViewType.banners:
      case ViewType.gridBanners:
        final banners = section.displayData.cast<BannerItem>();
        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: banners.length,
            itemBuilder: (context, index) => Image.network(banners[index].imageUrl),
          ),
        );

      case ViewType.icons:
        final brands = section.displayData.cast<BrandItem>();
        return Wrap(
          spacing: 16,
          runSpacing: 8,
          children: brands
              .map((b) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(b.imageUrl, width: 60, height: 60),
                      const SizedBox(height: 4),
                      Text(b.displayText, style: const TextStyle(fontSize: 12)),
                    ],
                  ))
              .toList(),
        );

      case ViewType.productList:
        final products = section.displayData.cast<ProductItem>();
        return Column(
          children: products
              .map((p) => ListTile(
                    leading: Image.network(p.imageUrl, width: 50, height: 50),
                    title: Text(p.title),
                    subtitle: Text("₹${p.sellingPrice}"),
                  ))
              .toList(),
        );

      case ViewType.unknown:
      default:
        return const SizedBox();
    }
  }*/
}
