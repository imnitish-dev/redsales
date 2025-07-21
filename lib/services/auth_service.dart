import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twocliq/helper/constants.dart';

import '../helper/apirequest.dart';

class AuthServices {

  static const String _hostUrl = "https://redsales.projectx38.cloud/app-apis/redsales/app";

  /// Registers a new customer
  /// Returns `true` if registration succeeds, `false` otherwise.
  static Future<bool> customerRegistration({
    required String contactNo,
    required String name,
    required String enterpriseName,
    required String emailId,
    required String password,
    required String whatsappNo,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String pinCode,
    required String storeName,
    required String state,
  }) async {
    final url = Uri.parse("$_hostUrl/customer/register");

    final Map<String, dynamic> requestBody = {
      "contactNo": contactNo,
      "name": name,
      "enterpriseName": enterpriseName,
      "emailId": emailId,
      "password": password,
      "whatsappNo": whatsappNo,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "city": city,
      "pinCode": pinCode,
      "storeName": storeName,
      "state": state,
    };

    try {

      String deviceId = await getDeviceId();
      String loginToken = await getLoginToken();
      Map<String, String> packageInfo = await getPackageInfo();

      // Combine all headers
      Map<String, String> fixedHeaders = {
        'device-id': deviceId,
        'login-token': loginToken,
        'source': 'CUSTOMER_APP',
        'content-type': 'application/json',
        ...packageInfo,
      };

      final response = await http.post(
        url,
        headers: fixedHeaders,
        body: jsonEncode(requestBody),
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception("Request timed out. Please try again.");
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == 1) {
          return true;
        } else {
          // If success is 0 and a message is present, print it
          final String? message = data["message"];
          if (message != null && message.isNotEmpty) {
            logError("Registration failed: $message");
            showCustomToast(msg: message);
          }
        }
      } else {
        logError("Server error: ${response.statusCode}");
      }

      return false;
    } catch (e) {
      showCustomToast(msg: "Registration Failed");
      logError("Error during registration: $e");
      return false;
    }
  }
}
