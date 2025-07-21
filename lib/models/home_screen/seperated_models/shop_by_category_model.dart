class ShopByCategoryModel {
  final String bannerId;
  final String imageUrl;
  final String displayText;
  final ShopByCategoryClickDetails? clickDetails;

  ShopByCategoryModel({
    required this.bannerId,
    required this.imageUrl,
    required this.displayText,
    this.clickDetails,
  });

  factory ShopByCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShopByCategoryModel(
      bannerId: json['bannerId'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      displayText: json['displayText'] ?? '',
      clickDetails: json['clickDetails'] != null
          ? ShopByCategoryClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}

class ShopByCategoryClickDetails {
  final String targetScreen;
  final Map<String, dynamic> targetData;

  ShopByCategoryClickDetails({
    required this.targetScreen,
    required this.targetData,
  });

  factory ShopByCategoryClickDetails.fromJson(Map<String, dynamic> json) {
    return ShopByCategoryClickDetails(
      targetScreen: json['targetScreen'] ?? '',
      targetData: json['targetData'] ?? {},
    );
  }
}
