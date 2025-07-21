import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/apirequest.dart';
import '../models/cart_list_model.dart';
import '../models/customer_profile_model.dart';

class CustomerService {
  static const String _hostUrlLOCAL = "https://two-cliq.imnitish.dev/redsales/app";
  static const String _hostUrl = "https://redsales.projectx38.cloud/app-apis/redsales/app";

  static Future<CustomerProfileModel> fetchCustomerProfile() async {
    final url = Uri.parse("$_hostUrlLOCAL/customer/profile");

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

      final response = await http.post(url, headers: headers).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        if (jsonBody['success'] == 1) {
          return CustomerProfileModel.fromJson(jsonBody['data']);
        } else {
          throw Exception(jsonBody['message'] ?? "API error");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch customer profile: $e");
    }
  }

  static Future<bool> addCustomerAddress({
    required String addressType,
    required String address,
    required String area,
    required String landmark,
    required String pincode,
    required String city,
    required String state,
  }) async {
    final url = Uri.parse("$_hostUrlLOCAL/address/add");

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
        "addressType": addressType,
        "address": address,
        "area": area,
        "landmark": landmark,
        "pincode": pincode,
        "city": city,
        "state": state,
      });

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        if (jsonBody['success'] == 1) {
          return true; // Address successfully added
        } else {
          throw Exception(jsonBody['message'] ?? "API error");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to add customer address: $e");
    }
  }


}
