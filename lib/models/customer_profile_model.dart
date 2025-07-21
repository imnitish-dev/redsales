class CustomerProfileModel {
  final String? id;
  final String? customerId;
  final CreatedAt? createdAt;
  final String? status;
  final CustomerDetails? customerDetails;
  final List<KycData>? kycData;
  final bool? isReferred;
  final String? referralCode;
  final String? referredBy;
  final CreatedAt? referredOn;
  final Address? address;
  final List<String>? userType;

  CustomerProfileModel({
    this.id,
    this.customerId,
    this.createdAt,
    this.status,
    this.customerDetails,
    this.kycData,
    this.isReferred,
    this.referralCode,
    this.referredBy,
    this.referredOn,
    this.address,
    this.userType,
  });

  factory CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    return CustomerProfileModel(
      id: json['_id'],
      customerId: json['customerId'],
      createdAt: json['createdAt'] != null ? CreatedAt.fromJson(json['createdAt']) : null,
      status: json['status'],
      customerDetails: json['customerDetails'] != null
          ? CustomerDetails.fromJson(json['customerDetails'])
          : null,
      kycData: (json['kycData'] as List<dynamic>? ?? [])
          .map((e) => KycData.fromJson(e))
          .toList(),
      isReferred: json['isReferred'],
      referralCode: json['referralCode'],
      referredBy: json['referredBy'],
      referredOn: json['referredOn'] != null ? CreatedAt.fromJson(json['referredOn']) : null,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      userType: (json['userType'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }
}

class CreatedAt {
  final int? timestamp;
  final dynamic isoDate; // Can be String or int, so keep dynamic

  CreatedAt({this.timestamp, this.isoDate});

  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      timestamp: json['timestamp'],
      isoDate: json['ISODate'],
    );
  }
}

class CustomerDetails {
  final String? customerName;
  final String? storeName;
  final String? contactNo;
  final String? emailId;
  final String? profileIcon;
  final String? kycStatus;
  final String? whatsappNo;

  CustomerDetails({
    this.customerName,
    this.storeName,
    this.contactNo,
    this.emailId,
    this.profileIcon,
    this.kycStatus,
    this.whatsappNo,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
      customerName: json['customerName'],
      storeName: json['storeName'],
      contactNo: json['contactNo'],
      emailId: json['emailId'],
      profileIcon: json['profileIcon'],
      kycStatus: json['kycStatus'],
      whatsappNo: json['whatsappNo'],
    );
  }
}

class KycData {
  final String? kycType;
  final String? documentType;
  final String? documentNo;
  final String? frontImage;
  final String? backImage;
  final String? status;

  KycData({
    this.kycType,
    this.documentType,
    this.documentNo,
    this.frontImage,
    this.backImage,
    this.status,
  });

  factory KycData.fromJson(Map<String, dynamic> json) {
    return KycData(
      kycType: json['kycType'],
      documentType: json['documentType'],
      documentNo: json['documentNo'],
      frontImage: json['frontImage'],
      backImage: json['backImage'],
      status: json['status'],
    );
  }
}

class Address {
  final String? storeName;
  final String? address;
  final String? city;
  final String? pinCode;
  final String? state;

  Address({
    this.storeName,
    this.address,
    this.city,
    this.pinCode,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      storeName: json['storeName'],
      address: json['address'],
      city: json['city'],
      pinCode: json['pinCode'],
      state: json['state'],
    );
  }
}
