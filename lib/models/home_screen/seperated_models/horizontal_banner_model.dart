class HorizontalBannerModel {
  final String? bannerId;
  final String? imageUrl;
  final HorizontalBannerClickDetails? clickDetails;

  HorizontalBannerModel({
    this.bannerId,
    this.imageUrl,
    this.clickDetails,
  });

  factory HorizontalBannerModel.fromJson(Map<String, dynamic> json) {
    return HorizontalBannerModel(
      bannerId: json['bannerId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      clickDetails: json['clickDetails'] != null
          ? HorizontalBannerClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}

class HorizontalBannerClickDetails {
  final String? targetScreen;
  final HorizontalBannerTargetData? targetData;

  HorizontalBannerClickDetails({
    this.targetScreen,
    this.targetData,
  });

  factory HorizontalBannerClickDetails.fromJson(Map<String, dynamic> json) {
    return HorizontalBannerClickDetails(
      targetScreen: json['targetScreen'] as String?,
      targetData: json['targetData'] != null
          ? HorizontalBannerTargetData.fromJson(json['targetData'])
          : null,
    );
  }
}

class HorizontalBannerTargetData {
  final String? bannerId;
  final String? productType;
  final String? typeValue;

  HorizontalBannerTargetData({
    this.bannerId,
    this.productType,
    this.typeValue,
  });

  factory HorizontalBannerTargetData.fromJson(Map<String, dynamic> json) {
    return HorizontalBannerTargetData(
      bannerId: json['bannerId'] as String?,
      productType: json['productType'] as String?,
      typeValue: json['typeValue'] as String?,
    );
  }
}
