import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/apirequest.dart';
import '../models/home_screen/home_screen_model.dart';

class HomeService {
  static const String _hostUrlLOCAL = "https://two-cliq.imnitish.dev/redsales/app";
  static const String _hostUrl = "https://redsales.projectx38.cloud/app-apis/redsales/app";

  static Future<HomeResponse> fetchHomeData() async {
    final url = Uri.parse("$_hostUrlLOCAL/home");

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

      final response = await http.post(url, headers: fixedHeaders).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception("Request timed out. Please try again.");
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == 1) {
          return HomeResponse.fromJson(json['data']);
        } else {
          throw Exception(json['message'] ?? "Unknown API error");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch home data: $e");
    }
  }
}
