import 'dart:convert';

class ProductDetailModel {
  final String? id;
  final String? productId;
  final String? barcodeId;
  final int? quantity;
  final DateInfo? createdAt;
  final String? status;
  final ProductDetails? productDetails;
  final List<String>? images;
  final List<dynamic>? inventory;
  final List<DetailProductSpecification>? specifications;
  final DetailProductPriceDetails? priceDetails;
  final List<dynamic>? inventorySpecificDetails;

  ProductDetailModel({
    this.id,
    this.productId,
    this.barcodeId,
    this.quantity,
    this.createdAt,
    this.status,
    this.productDetails,
    this.images,
    this.inventory,
    this.specifications,
    this.priceDetails,
    this.inventorySpecificDetails,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['_id'],
      productId: json['productId'],
      barcodeId: json['barcodeId'],
      quantity: json['quantity'],
      createdAt: json['createdAt'] != null ? DateInfo.fromJson(json['createdAt']) : null,
      status: json['status'],
      productDetails: json['productDetails'] != null
          ? ProductDetails.fromJson(json['productDetails'])
          : null,
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      inventory: json['inventory'] as List?,
      specifications: (json['specifications'] as List?)
          ?.map((e) => DetailProductSpecification.fromJson(e))
          .toList(),
      priceDetails:
      json['priceDetails'] != null ? DetailProductPriceDetails.fromJson(json['priceDetails']) : null,
      inventorySpecificDetails: json['inventorySpecificDetails'] as List?,
    );
  }
}

class DateInfo {
  final int? timestamp;
  final String? isoDate;

  DateInfo({this.timestamp, this.isoDate});

  factory DateInfo.fromJson(Map<String, dynamic> json) {
    return DateInfo(
      timestamp: json['timestamp'],
      isoDate: json['ISODate'],
    );
  }
}

class ProductDetails {
  final String? productTitle;
  final String? productDescription;
  final String? brand;
  final CategoryDetails? category;

  ProductDetails({
    this.productTitle,
    this.productDescription,
    this.brand,
    this.category,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      productTitle: json['productTitle'],
      productDescription: json['productDescription'],
      brand: json['brand'],
      category:
      json['category'] != null ? CategoryDetails.fromJson(json['category']) : null,
    );
  }
}

class CategoryDetails {
  final String? itemName;
  final String? categoryId;
  final String? categoryName;
  final String? subCategoryId;
  final String? subCategoryName;
  final List<String>? categoryIdArray;

  CategoryDetails({
    this.itemName,
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,
    this.categoryIdArray,
  });

  factory CategoryDetails.fromJson(Map<String, dynamic> json) {
    return CategoryDetails(
      itemName: json['itemName'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      subCategoryId: json['subCategoryId'],
      subCategoryName: json['subCategoryName'],
      categoryIdArray:
      (json['categoryIdArray'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}

class DetailProductSpecification {
  final String? key;
  final String? value;

  DetailProductSpecification({this.key, this.value});

  factory DetailProductSpecification.fromJson(Map<String, dynamic> json) {
    return DetailProductSpecification(
      key: json['key'],
      value: json['value'],
    );
  }
}

class DetailProductPriceDetails {
  final int? mrpPrice;
  final int? sellingPrice;
  final List<DetailProductCustomPrice>? customPrice;

  DetailProductPriceDetails({this.mrpPrice, this.sellingPrice, this.customPrice});

  factory DetailProductPriceDetails.fromJson(Map<String, dynamic> json) {
    return DetailProductPriceDetails(
      mrpPrice: json['mrpPrice'],
      sellingPrice: json['sellingPrice'],
      customPrice: (json['customPrice'] as List?)
          ?.map((e) => DetailProductCustomPrice.fromJson(e))
          .toList(),
    );
  }
}

class DetailProductCustomPrice {
  final int? maxQuantity;
  final int? sellingPrice;
  final String? customPriceId;

  DetailProductCustomPrice({this.maxQuantity, this.sellingPrice,this.customPriceId});

  factory DetailProductCustomPrice.fromJson(Map<String, dynamic> json) {
    return DetailProductCustomPrice(
      maxQuantity: json['maxQuantity'],
      sellingPrice: json['sellingPrice'],
      customPriceId: json['_id']
    );
  }
}
