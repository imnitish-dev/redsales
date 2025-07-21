import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/models/product_detail_model.dart';
import '../helper/apirequest.dart';
import '../models/home_screen/home_screen_model.dart';
import '../models/order_model.dart';

class OrderService {
  static const String _hostUrlLOCAL = "https://two-cliq.imnitish.dev/redsales/app";
  static const String _hostUrl = "https://redsales.projectx38.cloud/app-apis/redsales/app";

  static Future<List<OrderModel>> fetchOrders() async {
    final url = Uri.parse("$_hostUrlLOCAL/orders/list"); // Adjust endpoint

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

      // If your API needs filters, pagination, etc., add them here.
      final body = jsonEncode({}); // Empty if no parameters

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        if (jsonBody['success'] == 1) {
          final List<dynamic> data = jsonBody['data'];
          return data.map((e) => OrderModel.fromJson(e)).toList();
        } else {
          throw Exception(jsonBody['message'] ?? "API error");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }
}