class RecommendedCategoryModel {
  final String categoryName;
  final List<RecommendedProductItem> products;

  RecommendedCategoryModel({
    required this.categoryName,
    required this.products,
  });

  factory RecommendedCategoryModel.fromJson(String category, List<dynamic> jsonList) {
    return RecommendedCategoryModel(
      categoryName: category,
      products: jsonList
          .map((e) => RecommendedProductItem.fromJson(e))
          .toList(),
    );
  }
}

class RecommendedProductItem {
  final String productId;
  final String title;
  final String brand;
  final String imageUrl;
  final int quantity;
  final String category;
  final int mrpPrice;
  final int sellingPrice;
  final List<CustomPrice> customPrice;
  final bool isInCart;
  final int cartQuantity;
  final RecommendedProductClick? click;

  RecommendedProductItem({
    required this.productId,
    required this.title,
    required this.brand,
    required this.imageUrl,
    required this.quantity,
    required this.category,
    required this.mrpPrice,
    required this.sellingPrice,
    required this.customPrice,
    required this.isInCart,
    required this.cartQuantity,
    this.click,
  });

  factory RecommendedProductItem.fromJson(Map<String, dynamic> json) {
    return RecommendedProductItem(
      productId: json['productId'] ?? '',
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      quantity: json['quantity'] ?? 0,
      category: json['category'] ?? '',
      mrpPrice: json['priceDetails']?['mrpPrice'] ?? 0,
      sellingPrice: json['priceDetails']?['sellingPrice'] ?? 0,
      customPrice: (json['priceDetails']?['customPrice'] as List<dynamic>? ?? [])
          .map((e) => CustomPrice.fromJson(e))
          .toList(),
      isInCart: json['isInCart'] ?? false,
      cartQuantity: json['cartQuantity'] ?? 0,
      click: json['clickDetails'] != null
          ? RecommendedProductClick.fromJson(json['clickDetails'])
          : null,
    );
  }
}

class CustomPrice {
  final int maxQuantity;
  final int sellingPrice;

  CustomPrice({
    required this.maxQuantity,
    required this.sellingPrice,
  });

  factory CustomPrice.fromJson(Map<String, dynamic> json) {
    return CustomPrice(
      maxQuantity: json['maxQuantity'] ?? 0,
      sellingPrice: json['sellingPrice'] ?? 0,
    );
  }
}

class RecommendedProductClick {
  final String targetScreen;
  final Map<String, dynamic> targetData;

  RecommendedProductClick({
    required this.targetScreen,
    required this.targetData,
  });

  factory RecommendedProductClick.fromJson(Map<String, dynamic> json) {
    return RecommendedProductClick(
      targetScreen: json['targetScreen'] ?? '',
      targetData: json['targetData'] ?? {},
    );
  }
}



class RecommendedProductsSection {
  final String displayTitle;
  final List<RecommendedCategoryModel> categories;

  RecommendedProductsSection({
    required this.displayTitle,
    required this.categories,
  });

  factory RecommendedProductsSection.fromJson(Map<String, dynamic> json) {
    final data = json['displayData'] as Map<String, dynamic>;
    final categories = data.entries.map((entry) {
      return RecommendedCategoryModel.fromJson(entry.key, entry.value);
    }).toList();

    return RecommendedProductsSection(
      displayTitle: json['displayTitle'] ?? '',
      categories: categories,
    );
  }
}
