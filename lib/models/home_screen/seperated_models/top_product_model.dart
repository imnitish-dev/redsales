class TopProductModel {
  final String? bannerId;
  final String? imageUrl;
  final TopProductClickDetails? clickDetails;

  TopProductModel({
    this.bannerId,
    this.imageUrl,
    this.clickDetails,
  });

  factory TopProductModel.fromJson(Map<String, dynamic> json) {
    return TopProductModel(
      bannerId: json['bannerId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      clickDetails: json['clickDetails'] != null
          ? TopProductClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}

class TopProductClickDetails {
  final String? targetScreen;
  final TopProductTargetData? targetData;

  TopProductClickDetails({
    this.targetScreen,
    this.targetData,
  });

  factory TopProductClickDetails.fromJson(Map<String, dynamic> json) {
    return TopProductClickDetails(
      targetScreen: json['targetScreen'] as String?,
      targetData: json['targetData'] != null
          ? TopProductTargetData.fromJson(json['targetData'])
          : null,
    );
  }
}

class TopProductTargetData {
  final String? bannerId;
  final String? productType;
  final String? typeValue;

  TopProductTargetData({
    this.bannerId,
    this.productType,
    this.typeValue,
  });

  factory TopProductTargetData.fromJson(Map<String, dynamic> json) {
    return TopProductTargetData(
      bannerId: json['bannerId'] as String?,
      productType: json['productType'] as String?,
      typeValue: json['typeValue'] as String?,
    );
  }
}
