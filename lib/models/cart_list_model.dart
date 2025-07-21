class CartListModel {
  final List<CartProduct> cartProducts;
  final CartSummary? cartSummary;
  final List<Coupon> coupons;

  CartListModel({
    required this.cartProducts,
    this.cartSummary,
    required this.coupons,
  });

  factory CartListModel.fromJson(Map<String, dynamic> json) {
    return CartListModel(
      cartProducts: (json['cartProducts'] as List<dynamic>? ?? [])
          .map((e) => CartProduct.fromJson(e))
          .toList(),
      cartSummary: json['cartSummary'] != null
          ? CartSummary.fromJson(json['cartSummary'])
          : null,
      coupons: (json['coupons'] as List<dynamic>? ?? [])
          .map((e) => Coupon.fromJson(e))
          .toList(),
    );
  }
}

class CartProduct {
  final String? id;
  final String? cartId;
  final CreatedAt? createdAt;
  final String? status;
  final String? customerId;
  final String? productId;
  final String? productTitle;
  final String? brand;
  final String? productImage;
  final int? price;
  final int? quantity;
  final int? total;

  CartProduct({
    this.id,
    this.cartId,
    this.createdAt,
    this.status,
    this.customerId,
    this.productId,
    this.productTitle,
    this.brand,
    this.productImage,
    this.price,
    this.quantity,
    this.total,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['_id'],
      cartId: json['cartId'],
      createdAt: json['createdAt'] != null
          ? CreatedAt.fromJson(json['createdAt'])
          : null,
      status: json['status'],
      customerId: json['customerId'],
      productId: json['productId'],
      productTitle: json['productTitle'],
      brand: json['brand'],
      productImage: json['productImage'],
      price: json['price'],
      quantity: json['quantity'],
      total: json['total'],
    );
  }
}

class CreatedAt {
  final int? timestamp;
  final int? isoDate;

  CreatedAt({this.timestamp, this.isoDate});

  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      timestamp: json['timestamp'],
      isoDate: json['ISODate'],
    );
  }
}

class CartSummary {
  final int? itemAmount;
  final int? discountAmount;
  final int? taxAmount;
  final int? totalAmount;

  CartSummary({
    this.itemAmount,
    this.discountAmount,
    this.taxAmount,
    this.totalAmount,
  });

  factory CartSummary.fromJson(Map<String, dynamic> json) {
    return CartSummary(
      itemAmount: json['itemAmount'],
      discountAmount: json['discountAmount'],
      taxAmount: json['taxAmount'],
      totalAmount: json['totalAmount'],
    );
  }
}

class Coupon {
  final String? couponCode;
  final String? couponId;
  final String? title;
  final String? description;
  final int? minOrderAmount;
  final String? type;
  final int? value;
  final CouponData? couponData;
  final int? validUpto;
  final int? maxDiscountAmount;
  final String? status;
  final bool? hidden;
  final bool? applied;

  Coupon({
    this.couponCode,
    this.couponId,
    this.title,
    this.description,
    this.minOrderAmount,
    this.type,
    this.value,
    this.couponData,
    this.validUpto,
    this.maxDiscountAmount,
    this.status,
    this.hidden,
    this.applied,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponCode: json['couponCode'],
      couponId: json['couponId'],
      title: json['title'],
      description: json['description'],
      minOrderAmount: json['minOrderAmount'],
      type: json['type'],
      value: json['value'],
      couponData: json['couponData'] != null
          ? CouponData.fromJson(json['couponData'])
          : (json['couponFor'] != null
          ? CouponData.fromJson(json['couponFor'])
          : null),
      validUpto: json['validupto'],
      maxDiscountAmount: json['maxDiscountAmout'],
      status: json['status'],
      hidden: json['hidden'],
      applied: json['applied'],
    );
  }
}

class CouponData {
  final bool? allUsers;

  CouponData({this.allUsers});

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      allUsers: json['allUsers'],
    );
  }
}
