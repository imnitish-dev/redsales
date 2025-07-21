import 'package:flutter/material.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/models/cart_list_model.dart';
import 'package:twocliq/services/cart_service.dart';

import '../models/home_screen/home_screen_model.dart';
import '../services/home_service.dart';
import 'home_provider.dart';




class CartProvider extends ChangeNotifier {
  ApiLoadingState status = ApiLoadingState.loading;
  CartListModel? cartList;
  String? errorMessage;



  Future<void> loadCartData({String? couponCode}) async {
    status = ApiLoadingState.loading;
    notifyListeners();

    try {
      cartList = await CartService.fetchCartData(couponCode: couponCode);
      status = ApiLoadingState.success;
      logInfo("received cart items : ${cartList?.cartProducts.length}");
    } catch (e) {
      errorMessage = e.toString();
      status = ApiLoadingState.error;
      logError('failed to load cart items : $errorMessage');
    }
    notifyListeners();
  }

  Future<void> addProduct({
    required String productId,
    required int quantity,
}) async {

    status = ApiLoadingState.loading;
    notifyListeners();

    try {

      logInfo('productID : $productId');

      bool isDataPushed = await CartService.addProductToCart(productId: productId, quantity: quantity);
      if(isDataPushed){
        status = ApiLoadingState.success;
        logInfo("Product Added To Cart : $productId");
        showCustomToast(msg: 'Product Updated!');
        loadCartData();
        return;
      }else{
        logError('failed to add product to cart : $productId');
        showErrorToast(msg: 'Failed To Add to Cart');
      }
    } catch (e) {
      errorMessage = e.toString();
      status = ApiLoadingState.error;
    }
    notifyListeners();
  }


}
