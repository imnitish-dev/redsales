import 'package:flutter/material.dart';
import 'package:twocliq/models/product_detail_model.dart';
import 'package:twocliq/services/product_service.dart';

import '../helper/constants.dart';
import 'home_provider.dart';

class DetailedProductScreenProvider extends ChangeNotifier {
  ApiLoadingState status = ApiLoadingState.loading;
  ProductDetailModel? currentProductDetail;
  String? errorMessage;

  Future<void> loadProductDetail({required String productId}) async {
    status = ApiLoadingState.loading;
    notifyListeners();

    try {
      currentProductDetail = await ProductService.fetchProductDetails(productId: productId);
      status = ApiLoadingState.success;
      logInfo("received product : ${currentProductDetail?.id}");
    } catch (e) {
      errorMessage = e.toString();
      status = ApiLoadingState.error;
      logError('failed to load profile data : $errorMessage');
    }

    notifyListeners();
  }
}
