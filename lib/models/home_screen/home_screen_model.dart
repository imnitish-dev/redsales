import 'package:twocliq/models/home_screen/seperated_models/announcement_model.dart';
import 'package:twocliq/models/home_screen/seperated_models/horizontal_banner_model.dart';
import 'package:twocliq/models/home_screen/seperated_models/horizontal_icon_model.dart';
import 'package:twocliq/models/home_screen/seperated_models/recommended_product_item_model.dart';
import 'package:twocliq/models/home_screen/seperated_models/shop_by_category_model.dart';
import 'package:twocliq/models/home_screen/seperated_models/top_product_model.dart';

import 'home_screen_enums.dart';

class HomeResponse {
  final List<HomeSection> home;
  final int cartCount;
  final int notificationCount;

  HomeResponse({
    required this.home,
    required this.cartCount,
    required this.notificationCount,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      home: (json['home'] as List<dynamic>)
          .map((e) => HomeSection.fromJson(e))
          .toList(),
      cartCount: json['counts']?['cart'] ?? 0,
      notificationCount: json['counts']?['notification'] ?? 0,
    );
  }
}

class HomeSection {
  final ViewType viewType;
  final String displayTitle;
  final List<dynamic> displayData;

  HomeSection({
    required this.viewType,
    required this.displayTitle,
    required this.displayData,
  });

  factory HomeSection.fromJson(Map<String, dynamic> json) {
    final type = ViewType.fromString(json['viewType'] ?? '');

    List<dynamic> parsedData;
    switch (type) {
      case ViewType.banners:
        parsedData = (json['displayData'] as List<dynamic>)
            .map((e) => HorizontalBannerModel.fromJson(e))
            .toList();
        break;
      case ViewType.gridBanners:
      case ViewType.horizontalIcons:
        parsedData = (json['displayData'] as List<dynamic>)
            .map((e) => HorizontalIconModel.fromJson(e))
            .toList();
        break;
      case ViewType.shopByCategories:
        parsedData = (json['displayData'] as List<dynamic>)
            .map((e) => ShopByCategoryModel.fromJson(e))
            .toList();
        break;
      case ViewType.topProducts:
        parsedData = (json['displayData'] as List<dynamic>)
            .map((e) => TopProductModel.fromJson(e))
            .toList();
        break;

      case ViewType.icons:
        parsedData = (json['displayData'] as List<dynamic>)
            .map((e) => BrandItem.fromJson(e))
            .toList();
        break;

      case ViewType.verticalBanners:
        parsedData = (json['displayData'] as List<dynamic>)
            .map((e) => VerticalBannerItem.fromJson(e))
            .toList();
        break;

      case ViewType.announcement:
        parsedData = (json['displayData'] as List<dynamic>)
            .map((e) => AnnouncementItem.fromJson(e))
            .toList();
        break;

      case ViewType.productList:
        parsedData = (json['displayData'] as List<dynamic>)
            .map((e) => ProductItem.fromJson(e))
            .toList();
        break;

      case ViewType.recommendedProducts:
        final displayMap = json['displayData'] as Map<String, dynamic>;
        parsedData = displayMap.entries.map((entry) {
          return RecommendedCategoryModel.fromJson(entry.key, entry.value);
        }).toList();
        break;

      default:
        parsedData = [];
    }

    return HomeSection(
      viewType: type,
      displayTitle: json['displayTitle'] ?? '',
      displayData: parsedData,
    );
  }
}

/// ClickDetails remains unchanged
class ClickDetails {
  final TargetScreen targetScreen;
  final Map<String, dynamic> targetData;

  ClickDetails({required this.targetScreen, required this.targetData});

  factory ClickDetails.fromJson(Map<String, dynamic> json) {
    return ClickDetails(
      targetScreen: TargetScreen.fromString(json['targetScreen']),
      targetData: json['targetData'] ?? {},
    );
  }
}

/// BannerItem (for banners, grid, shop by categories, etc.)
class BannerItem {
  final String imageUrl;
  final String? displayText;
  final ClickDetails? clickDetails;

  BannerItem({
    required this.imageUrl,
    this.displayText,
    this.clickDetails,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      imageUrl: json['imageUrl'] ?? '',
      displayText: json['displayText'],
      clickDetails: json['clickDetails'] != null
          ? ClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}

/// BrandItem (used for ICONS)
class BrandItem {
  final String displayText;
  final String imageUrl;
  final ClickDetails? clickDetails;

  BrandItem({
    required this.displayText,
    required this.imageUrl,
    this.clickDetails,
  });

  factory BrandItem.fromJson(Map<String, dynamic> json) {
    return BrandItem(
      displayText: json['displayText'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      clickDetails: json['clickDetails'] != null
          ? ClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}

/// ProductItem (used for PRODUCT_LIST)
class ProductItem {
  final String productId;
  final String title;
  final String imageUrl;
  final int mrpPrice;
  final int sellingPrice;
  final ClickDetails? clickDetails;

  ProductItem({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.mrpPrice,
    required this.sellingPrice,
    this.clickDetails,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      productId: json['productId'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      mrpPrice: json['priceDetails']?['mrpPrice'] ?? 0,
      sellingPrice: json['priceDetails']?['sellingPrice'] ?? 0,
      clickDetails: json['clickDetails'] != null
          ? ClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}



/// New: VerticalBannerItem (for VERTICAL_BANNERS)
class VerticalBannerItem {
  final String imageUrl;
  final String? displayText;
  final String? displayText2;
  final ClickDetails? clickDetails;

  VerticalBannerItem({
    required this.imageUrl,
    this.displayText,
    this.displayText2,
    this.clickDetails,
  });

  factory VerticalBannerItem.fromJson(Map<String, dynamic> json) {
    return VerticalBannerItem(
      imageUrl: json['imageUrl'] ?? '',
      displayText: json['displayText'],
      displayText2: json['displayText2'],
      clickDetails: json['clickDetails'] != null
          ? ClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}
