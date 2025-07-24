import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twocliq/helper/constants.dart';
import '../helper/apirequest.dart';
import '../models/order_model.dart';
import '../models/wishlist_model.dart';

class WishlistService {
  static const String _hostUrlLOCAL = "https://two-cliq.imnitish.dev/redsales/app";
  static const String _hostUrl = "https://redsales.projectx38.cloud/app-apis/redsales/app";

  static Future<List<WishlistItem>> fetchWishlist() async {
    final url = Uri.parse("$_hostUrlLOCAL/wishlist/list");

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

      final body = jsonEncode({});

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        if (jsonBody['success'] == 1) {
          final List<dynamic> data = jsonBody['data']['wishlistItems'] ?? [];
          return data.map((e) => WishlistItem.fromJson(e)).toList();
        } else {
          throw Exception(jsonBody['message'] ?? "API error");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch wishlist: $e");
    }
  }

  static Future<bool> deleteWishlistItemUsingWishlistID({required String wishlistId}) async {
    final url = Uri.parse("$_hostUrlLOCAL/wishlist/remove");

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
        "wishlistId": wishlistId,
      });

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        if (jsonBody['success'] == 1) {
          return true; // Successfully deleted
        } else {
          throw Exception(jsonBody['message'] ?? "Failed to delete wishlist item");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to delete wishlist item: $e");
    }
  }

  static Future<bool> deleteWishlistItemUsingProductID({required String wishlistId}) async {
    final url = Uri.parse("$_hostUrlLOCAL/wishlist/remove");

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
        "productId": wishlistId,
      });

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        if (jsonBody['success'] == 1) {
          return true; // Successfully deleted
        } else {
          throw Exception(jsonBody['message'] ?? "Failed to delete wishlist item");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to delete wishlist item: $e");
    }
  }

  static Future<bool> addProductToWishlist({required String productId}) async {
    final url = Uri.parse("$_hostUrlLOCAL/wishlist/add");

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
      });

      final response = await http.post(url, headers: headers, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out."),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        if (jsonBody['success'] == 1) {
          return true; // Product successfully added to wishlist
        } else {
          throw Exception(jsonBody['message'] ?? "Failed to add product to wishlist");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to add product to wishlist: $e");
    }
  }


}