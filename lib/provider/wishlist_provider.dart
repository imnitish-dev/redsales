import 'package:flutter/material.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/models/cart_list_model.dart';
import 'package:twocliq/models/order_model.dart';
import 'package:twocliq/services/cart_service.dart';
import 'package:twocliq/services/wishlist_service.dart';

import '../models/home_screen/home_screen_model.dart';
import '../models/wishlist_model.dart';
import '../services/home_service.dart';
import '../services/orders_service.dart';
import 'home_provider.dart';




class WishlistProvider extends ChangeNotifier {
  ApiLoadingState status = ApiLoadingState.loading;
  List<WishlistItem>? wishlist;
  String? errorMessage;

  /// Fetch all wishlist for the customer
  Future<void> loadWishlist() async {
    status = ApiLoadingState.loading;
    notifyListeners();

    try {
      wishlist = await WishlistService.fetchWishlist();
      status = ApiLoadingState.success;
      logInfo("Fetched ${wishlist?.length ?? 0} wishlist");
    } catch (e) {
      errorMessage = e.toString();
      status = ApiLoadingState.error;
      logError("Failed to load wishlist: $errorMessage");
      showErrorToast(msg: "Failed to fetch wishlist");
    }
    notifyListeners();
  }

  /// Refresh wishlist
  Future<void> refreshOrders() async {
    await loadWishlist();
  }

  void setWishlistManually({required List<WishlistItem> newWishlist}){
    wishlist = newWishlist;
    notifyListeners();
  }
}
