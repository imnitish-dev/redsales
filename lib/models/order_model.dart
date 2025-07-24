class OrderModel {
  final String? id;
  final String? orderId;
  final OrderDate? orderDate;
  final String? status;
  final CustomerDetails? customerDetails;
  final DeliveryAddress? deliveryAddress;
  final List<Product>? products;
  final List<LogEntry>? logs;
  final PaymentSummary? paymentSummary;
  final bool? buyerDeliveryConfirmation;

  OrderModel({
    this.id,
    this.orderId,
    this.orderDate,
    this.status,
    this.customerDetails,
    this.deliveryAddress,
    this.products,
    this.logs,
    this.paymentSummary,
    this.buyerDeliveryConfirmation,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      orderId: json['orderId'],
      orderDate:
      json['orderDate'] != null ? OrderDate.fromJson(json['orderDate']) : null,
      status: json['status'],
      customerDetails: json['customerDetails'] != null
          ? CustomerDetails.fromJson(json['customerDetails'])
          : null,
      deliveryAddress: json['deliveryAddress'] != null
          ? DeliveryAddress.fromJson(json['deliveryAddress'])
          : null,
      products: (json['products'] as List<dynamic>?)
          ?.map((p) => Product.fromJson(p))
          .toList() ??
          [],
      logs: (json['logs'] as List<dynamic>?)
          ?.map((l) => LogEntry.fromJson(l))
          .toList() ??
          [],
      paymentSummary: json['paymentSummary'] != null
          ? PaymentSummary.fromJson(json['paymentSummary'])
          : null,
      buyerDeliveryConfirmation: json['buyerDeliveryConfirmation'],
    );
  }

  String? getLatestLogType(List<LogEntry>? logs) {
    if (logs == null || logs.isEmpty) return null;

    // Sort by timestamp (latest first)
    logs.sort((a, b) {
      final tsA = a.logDate?.timestamp ?? 0;
      final tsB = b.logDate?.timestamp ?? 0;
      return tsB.compareTo(tsA);
    });

    final logType = logs.first.logType ?? "";

    // Map logType to readable string
    switch (logType) {
      case "ORDER_PLACED":
        return "Order Placed";
      case "ORDER_MARKED_RECEIVED":
        return "Order Received";
      default:
        return logType.isNotEmpty ? logType : null; // Fallback to original if unknown
    }
  }

  int? getLatestLogStep(List<LogEntry>? logs) {
    if (logs == null || logs.isEmpty) return null;

    // Sort by timestamp (latest first)
    logs.sort((a, b) {
      final tsA = a.logDate?.timestamp ?? 0;
      final tsB = b.logDate?.timestamp ?? 0;
      return tsB.compareTo(tsA);
    });

    final logType = logs.first.logType ?? "";

    // Map logType to step number
    switch (logType) {
      case "ORDER_PLACED":
        return 1;
      case "ORDER_MARKED_RECEIVED":
        return 2;
      default:
        return null; // unknown log type, no step
    }
  }


}

class OrderDate {
  final int? timestamp;
  final dynamic isoDate;

  OrderDate({this.timestamp, this.isoDate});

  factory OrderDate.fromJson(Map<String, dynamic> json) {
    return OrderDate(
      timestamp: json['timestamp'],
      isoDate: json['ISODate'],
    );
  }
}

class CustomerDetails {
  final String? customerId;
  final String? customerName;
  final String? storeName;
  final String? contactNo;
  final String? emailId;
  final String? profileIcon;

  CustomerDetails({
    this.customerId,
    this.customerName,
    this.storeName,
    this.contactNo,
    this.emailId,
    this.profileIcon,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
      customerId: json['customerId'],
      customerName: json['customerName'],
      storeName: json['storeName'],
      contactNo: json['contactNo'],
      emailId: json['emailId'],
      profileIcon: json['profileIcon'],
    );
  }
}

class DeliveryAddress {
  final String? addressId;
  final String? addressType;
  final String? address;
  final String? area;
  final String? landmark;
  final String? pincode;
  final String? city;
  final String? state;

  DeliveryAddress({
    this.addressId,
    this.addressType,
    this.address,
    this.area,
    this.landmark,
    this.pincode,
    this.city,
    this.state,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      addressId: json['addressId'],
      addressType: json['addressType'],
      address: json['address'],
      area: json['area'],
      landmark: json['landmark'],
      pincode: json['pincode'],
      city: json['city'],
      state: json['state'],
    );
  }
}

class Product {
  final String? productId;
  final String? productTitle;
  final String? brand;
  final String? categoryName;
  final String? imageUrl;
  final int? quantity;
  final int? mrpPrice;
  final int? sellingPrice;

  Product({
    this.productId,
    this.productTitle,
    this.brand,
    this.categoryName,
    this.imageUrl,
    this.quantity,
    this.mrpPrice,
    this.sellingPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      productTitle: json['productTitle'],
      brand: json['brand'],
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
      mrpPrice: json['mrpPrice'],
      sellingPrice: json['sellingPrice'],
    );
  }
}

class LogEntry {
  final String? logType;
  final OrderDate? logDate;
  final LogUser? logUser;

  LogEntry({this.logType, this.logDate, this.logUser});

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      logType: json['logType'],
      logDate:
      json['logDate'] != null ? OrderDate.fromJson(json['logDate']) : null,
      logUser: json['logUser'] != null ? LogUser.fromJson(json['logUser']) : null,
    );
  }
}

class LogUser {
  final String? userId;
  final String? name;

  LogUser({this.userId, this.name});

  factory LogUser.fromJson(Map<String, dynamic> json) {
    return LogUser(
      userId: json['userId'],
      name: json['name'],
    );
  }
}

class PaymentSummary {
  final int? itemAmount;
  final int? taxAmount;
  final int? shippingAmount;
  final int? finalAmount;
  final String? paymentMode;
  final int? walletUsed;
  final int? otherPaymentAmount;

  PaymentSummary({
    this.itemAmount,
    this.taxAmount,
    this.shippingAmount,
    this.finalAmount,
    this.paymentMode,
    this.walletUsed,
    this.otherPaymentAmount,
  });

  factory PaymentSummary.fromJson(Map<String, dynamic> json) {
    return PaymentSummary(
      itemAmount: json['itemAmount'],
      taxAmount: json['taxAmount'],
      shippingAmount: json['shippingAmount'],
      finalAmount: json['finalAmount'],
      paymentMode: json['paymentMode'],
      walletUsed: json['walletUsed'],
      otherPaymentAmount: json['otherPaymentAmount'],
    );
  }
}


