import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/models/product_detail_model.dart';
import '../helper/apirequest.dart';
import '../models/home_screen/home_screen_model.dart';

class ProductService {
  static const String _hostUrlLOCAL = "https://two-cliq.imnitish.dev/redsales/app";
  static const String _hostUrl = "https://redsales.projectx38.cloud/app-apis/redsales/app";

  static Future<ProductDetailModel> fetchProductDetails({required String productId}) async {
    final url = Uri.parse("$_hostUrlLOCAL/product/details");

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

      // Pass productId in body
      final body = jsonEncode({"productId": productId});

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        if (jsonBody['success'] == 1) {
          return ProductDetailModel.fromJson(jsonBody['data']);
        } else {
          throw Exception(jsonBody['message'] ?? "API error");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch product details: $e");
    }
  }

  static Future<bool> placeOrder({
    required String addressId,
    required List<Map<String, dynamic>> products,
    required int itemAmount,
    required int taxAmount,
    required int shippingAmount,
    required int finalAmount,
    required String paymentMode,
  }) async {

    logInfo('placing order..');

    final url = Uri.parse("$_hostUrlLOCAL/orders/add");

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
        "addressId": addressId,
        "products": products,
        "itemAmount": itemAmount,
        "taxAmount": taxAmount,
        "shippingAmount": shippingAmount,
        "finalAmount": finalAmount,
        "paymentMode": paymentMode,
      });

      logInfo(body);

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        logInfo(jsonBody);
        return jsonBody['success'] == 1;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


}