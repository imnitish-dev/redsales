import 'package:flutter/material.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/models/cart_list_model.dart';
import 'package:twocliq/models/order_model.dart';
import 'package:twocliq/services/cart_service.dart';

import '../models/home_screen/home_screen_model.dart';
import '../services/home_service.dart';
import '../services/orders_service.dart';
import 'home_provider.dart';




class OrdersProvider extends ChangeNotifier {
  ApiLoadingState status = ApiLoadingState.loading;
  List<OrderModel>? orders;
  String? errorMessage;

  /// Fetch all orders for the customer
  Future<void> loadOrders() async {
    status = ApiLoadingState.loading;
    notifyListeners();

    try {
      orders = await OrderService.fetchOrders();
      status = ApiLoadingState.success;
      logInfo("Fetched ${orders?.length ?? 0} orders");
    } catch (e) {
      errorMessage = e.toString();
      status = ApiLoadingState.error;
      logError("Failed to load orders: $errorMessage");
      showErrorToast(msg: "Failed to fetch orders");
    }
    notifyListeners();
  }

  /// Refresh orders (alias for reload)
  Future<void> refreshOrders() async {
    await loadOrders();
  }
}
