import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twocliq/helper/constants.dart';
import '../helper/apirequest.dart';
import '../models/cart_list_model.dart';
import '../models/home_screen/home_screen_model.dart';

class CartService {
  static const String _hostUrlLOCAL = "https://two-cliq.imnitish.dev/redsales/app";
  static const String _hostUrl = "https://redsales.projectx38.cloud/app-apis/redsales/app";

  static Future<CartListModel> fetchCartData({String? couponCode}) async {
    final url = Uri.parse("$_hostUrlLOCAL/cart/list");

    try {
      String deviceId = await getDeviceId();
      String loginToken = await getLoginToken();
      Map<String, String> packageInfo = await getPackageInfo();

      Map<String, String> headers = {
        'device-id': deviceId,
        'login-token': loginToken,
        'source': 'CUSTOMER_APP',
        'content-type': 'application/json',
        ...packageInfo,
      };

      // Build request body dynamically
      final Map<String, dynamic> body = {};
      if (couponCode != null && couponCode.isNotEmpty) {
        body['couponCode'] = couponCode;
      }

      final response = await http
          .post(url, headers: headers, body: jsonEncode(body))
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        logInfo(jsonBody);
        if (jsonBody['success'] == 1) {
          return CartListModel.fromJson(jsonBody['data']);
        } else {
          throw Exception(jsonBody['message'] ?? "Unknown API error");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch cart data: $e");
    }
  }



  static Future<bool> addProductToCart({
    required String productId,
    required int quantity,
  }) async {
    final url = Uri.parse("$_hostUrl/cart/add");

    try {
      String deviceId = await getDeviceId();
      String loginToken = await getLoginToken();
      Map<String, String> packageInfo = await getPackageInfo();

      Map<String, String> headers = {
        'device-id': deviceId,
        'login-token': loginToken,
        'source': 'CUSTOMER_APP',
        'content-type': 'application/json',
        ...packageInfo,
      };

      final body = jsonEncode({
        "productId": productId,
        "quantity": quantity,
      });

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        logInfo(jsonBody);

        if (jsonBody['success'] == 1) {
          return true;
        } else {
          throw Exception(jsonBody['message'] ?? "Failed to add product to cart");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to add product to cart: $e");
    }
  }



  static Future<bool> clearCart({required String cartId}) async {
    final url = Uri.parse("$_hostUrlLOCAL/cart/delete");

    try {
      String deviceId = await getDeviceId();
      String loginToken = await getLoginToken();
      Map<String, String> packageInfo = await getPackageInfo();

      Map<String, String> headers = {
        'device-id': deviceId,
        'login-token': loginToken,
        'source': 'CUSTOMER_APP',
        'content-type': 'application/json',
        ...packageInfo,
      };

      final body = jsonEncode({"cartId": cartId});

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        if (jsonBody['success'] == 1) {
          return true; // Cart cleared successfully
        } else {
          throw Exception(jsonBody['message'] ?? "API error");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to clear cart: $e");
    }
  }


}
