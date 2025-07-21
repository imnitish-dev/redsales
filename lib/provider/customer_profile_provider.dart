import 'package:flutter/material.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/models/customer_profile_model.dart';
import 'package:twocliq/services/customer_profile_service.dart';

import '../models/home_screen/home_screen_model.dart';
import '../services/home_service.dart';
import 'cart_provider.dart';
import 'home_provider.dart';

class CustomerProfileProvider extends ChangeNotifier {
  ApiLoadingState status = ApiLoadingState.loading;
  CustomerProfileModel? customerProfile;
  String? errorMessage;

  Future<void> loadProfileData() async {
    status = ApiLoadingState.loading;
    notifyListeners();

    try {
      customerProfile = await CustomerService.fetchCustomerProfile();
      status = ApiLoadingState.success;
      logInfo("received profile : ${customerProfile?.customerDetails}");
      logInfo("customer address : ${customerProfile?.addresses}");
    } catch (e) {
      errorMessage = e.toString();
      status = ApiLoadingState.error;
      logError('failed to load profile data : $errorMessage');
    }

    notifyListeners();
  }
}
