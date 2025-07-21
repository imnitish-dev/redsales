class AnnouncementItem {
  final String announcementId;
  final String announcementText;
  final AnnouncementClickDetails? clickDetails;

  AnnouncementItem({
    required this.announcementId,
    required this.announcementText,
    this.clickDetails,
  });

  factory AnnouncementItem.fromJson(Map<String, dynamic> json) {
    return AnnouncementItem(
      announcementId: json['announcementId'] ?? '',
      announcementText: json['announcementText'] ?? '',
      clickDetails: json['clickDetails'] != null
          ? AnnouncementClickDetails.fromJson(json['clickDetails'])
          : null,
    );
  }
}

class AnnouncementClickDetails {
  final String targetScreen;
  final Map<String, dynamic> targetData;

  AnnouncementClickDetails({
    required this.targetScreen,
    required this.targetData,
  });

  factory AnnouncementClickDetails.fromJson(Map<String, dynamic> json) {
    return AnnouncementClickDetails(
      targetScreen: json['targetScreen'] ?? '',
      targetData: json['targetData'] ?? {},
    );
  }
}
