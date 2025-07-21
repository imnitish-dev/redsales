class HorizontalIconModel {
  final String bannerId;
  final String imageUrl;
  final String displayText;
  final HorizontalIconClickDetails? clickDetails;

  HorizontalIconModel({
    required this.bannerId,
    required this.imageUrl,
    required this.displayText,
    this.clickDetails,
  });

  factory HorizontalIconModel.fromJson(Map<String, dynamic> json) {
    return HorizontalIconModel(
      bannerId: json['bannerId'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      displayText: json['displayText'] ?? '',
      clickDetails: json['clickDetails'] != null
          ? HorizontalIconClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}

class HorizontalIconClickDetails {
  final String targetScreen;
  final Map<String, dynamic> targetData;

  HorizontalIconClickDetails({
    required this.targetScreen,
    required this.targetData,
  });

  factory HorizontalIconClickDetails.fromJson(Map<String, dynamic> json) {
    return HorizontalIconClickDetails(
      targetScreen: json['targetScreen'] ?? '',
      targetData: json['targetData'] ?? {},
    );
  }
}
