enum ViewType {
  banners,
  gridBanners,
  icons,
  horizontalIcons,
  shopByCategories,
  topProducts,
  verticalBanners,
  announcement,
  productList,
  recommendedProducts,
  unknown;

  static ViewType fromString(String value) {
    switch (value.toUpperCase()) {
      case "BANNERS":
        return ViewType.banners;
      case "GRID_BANNERS":
        return ViewType.gridBanners;
      case "ICONS":
        return ViewType.icons;
      case "HORIZONTAL_ICONS":
        return ViewType.horizontalIcons;
      case "SHOP_BY_CATEGORIES":
        return ViewType.shopByCategories;
      case "TOP_PRODUCTS":
        return ViewType.topProducts;
      case "VERTICAL_BANNERS":
        return ViewType.verticalBanners;
      case "ANNOUNCEMENT":
        return ViewType.announcement;
      case "PRODUCT_LIST":
        return ViewType.productList;
      case "RECOMMENDED_PRODUCTS":
        return ViewType.recommendedProducts;
      default:
        return ViewType.unknown;
    }
  }
}

enum TargetScreen {
  productList,
  productDetails,
  brandList,
  announcementClick,
  unknown;

  static TargetScreen fromString(String? value) {
    switch (value?.toUpperCase()) {
      case "PRODUCT_LIST":
        return TargetScreen.productList;
      case "PRODUCT_DETAILS":
        return TargetScreen.productDetails;
      case "BRAND_LIST":
        return TargetScreen.brandList;
      case "ANNOUNCEMENT_CLICK":
        return TargetScreen.announcementClick;
      default:
        return TargetScreen.unknown;
    }
  }
}
