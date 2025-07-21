import 'package:flutter/material.dart';
import 'package:twocliq/helper/constants.dart';

import '../models/home_screen/home_screen_model.dart';
import '../services/home_service.dart';

enum ApiLoadingState { loading, success, error }

class HomeProvider extends ChangeNotifier {
  ApiLoadingState status = ApiLoadingState.loading;
  HomeResponse? homeResponse;
  String? errorMessage;

  Future<void> loadHomeData() async {
    status = ApiLoadingState.loading;
    notifyListeners();

    try {
      homeResponse = await HomeService.fetchHomeData();
      status = ApiLoadingState.success;
      logInfo("received items : ${homeResponse?.home.length}");
    } catch (e) {
      errorMessage = e.toString();
      status = ApiLoadingState.error;
      logError('failed to load profile data : $errorMessage');
    }
    notifyListeners();
  }
}
