class WishlistItem {
  final String? wishlistId;
  final String? productId;
  final String? productTitle;
  final String? brand;
  final String? productImage;
  final String? category;
  final PriceDetails? priceDetails;
  final AddedAt? addedAt;
  final ClickDetails? clickDetails;

  WishlistItem({
    this.wishlistId,
    this.productId,
    this.productTitle,
    this.brand,
    this.productImage,
    this.category,
    this.priceDetails,
    this.addedAt,
    this.clickDetails,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      wishlistId: json['wishlistId'],
      productId: json['productId'],
      productTitle: json['productTitle'],
      brand: json['brand'],
      productImage: json['productImage'],
      category: json['category'],
      priceDetails: json['priceDetails'] != null
          ? PriceDetails.fromJson(json['priceDetails'])
          : null,
      addedAt: json['addedAt'] != null ? AddedAt.fromJson(json['addedAt']) : null,
      clickDetails: json['clickDetails'] != null
          ? ClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}

class PriceDetails {
  final int? mrpPrice;
  final int? sellingPrice;
  final List<CustomPrice>? customPrice;

  PriceDetails({this.mrpPrice, this.sellingPrice, this.customPrice});

  factory PriceDetails.fromJson(Map<String, dynamic> json) {
    return PriceDetails(
      mrpPrice: json['mrpPrice'],
      sellingPrice: json['sellingPrice'],
      customPrice: (json['customPrice'] as List<dynamic>?)
          ?.map((e) => CustomPrice.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class CustomPrice {
  final int? maxQuantity;
  final int? sellingPrice;
  final String? id;

  CustomPrice({this.maxQuantity, this.sellingPrice, this.id});

  factory CustomPrice.fromJson(Map<String, dynamic> json) {
    return CustomPrice(
      maxQuantity: json['maxQuantity'],
      sellingPrice: json['sellingPrice'],
      id: json['_id'],
    );
  }
}

class AddedAt {
  final int? timestamp;
  final String? isoDate;

  AddedAt({this.timestamp, this.isoDate});

  factory AddedAt.fromJson(Map<String, dynamic> json) {
    return AddedAt(
      timestamp: json['timestamp'],
      isoDate: json['ISODate'],
    );
  }
}

class ClickDetails {
  final String? targetScreen;
  final TargetData? targetData;

  ClickDetails({this.targetScreen, this.targetData});

  factory ClickDetails.fromJson(Map<String, dynamic> json) {
    return ClickDetails(
      targetScreen: json['targetScreen'],
      targetData: json['targetData'] != null
          ? TargetData.fromJson(json['targetData'])
          : null,
    );
  }
}

class TargetData {
  final String? productId;

  TargetData({this.productId});

  factory TargetData.fromJson(Map<String, dynamic> json) {
    return TargetData(productId: json['productId']);
  }
}
