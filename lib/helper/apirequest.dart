import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

// const String hostUrl =
// 'https://redsales.projectx38.cloud/app-apis/redsales/app';
// const String hostUrl = 'http://10.0.2.2:38301/redsales/app';
const String hostUrl = 'https://redsales.projectx38.cloud/app-apis/redsales/app';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? responseBody;

  ApiException(this.message, [this.statusCode, this.responseBody]);

  @override
  String toString() {
    String result = 'ApiException: $message';
    if (statusCode != null) {
      result += ' (Status Code: $statusCode)';
    }
    if (responseBody != null) {
      result += '\nResponse Body: $responseBody';
    }
    return result;
  }
}

Future<String> getDeviceId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? deviceId = prefs.getString('deviceId');

  if (deviceId != null && deviceId.isNotEmpty) {
    return deviceId;
  }

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? 'unknown';
    } else {
      deviceId = 'unknown';
    }

    await prefs.setString('deviceId', deviceId);
  } catch (e) {
    deviceId = 'unknown';
  }

  return deviceId;
}

Future<String> getLoginToken() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loginToken') ?? 'NA';
  } catch (e) {
    return 'NA';
  }
}

Future<Map<String, String>> getPackageInfo() async {
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    return {
      'app-version': packageInfo.version,
      'build-number': packageInfo.buildNumber,
    };
  } catch (e) {
    print('Error getting package info: $e');
    return {
      'app-version': '1.0.0',
      'build-number': '1',
    };
  }
}

Future<String> getCurlCommand(
    String url, String method, Map<String, String> headers, String body) async {
  String deviceId = await getDeviceId();
  String loginToken = await getLoginToken();
  Map<String, String> packageInfo = await getPackageInfo();
  String appVersion = packageInfo['app-version'] ?? '1.0.0';
  String buildNumber = packageInfo['build-number'] ?? '1';
  String curlCommand =
      'curl -X $method -H "Content-Type: application/json" -H "device-id: $deviceId" -H "login-token: $loginToken" -H "source: CUSTOMER_APP" -H "app-version: $appVersion" -H "build-number: $buildNumber" -d "$body" $url';
  return curlCommand;
}

Future<dynamic> makeApiCall({
  required String endpoint,
  required String method,
  Map<String, String>? headers,
  dynamic body,
  Duration timeout = const Duration(seconds: 30),
}) async {
  final String fullUrl = '$hostUrl$endpoint';
  print('Request URL: $fullUrl');
  try {
    String deviceId = await getDeviceId();
    String loginToken = await getLoginToken();
    Map<String, String> packageInfo = await getPackageInfo();

    Map<String, String> fixedHeaders = {
      'device-id': deviceId,
      'login-token': loginToken,
      'source': 'CUSTOMER_APP',
      'content-type': 'application/json',
      ...packageInfo,
    };

    headers = {...fixedHeaders, ...?headers};

    // print('Request URL: $headers');

    String encodedBody = '';
    if (body != null) {
      encodedBody = jsonEncode(body);
    }
    String curlCommand =
        await getCurlCommand(fullUrl, method, headers, encodedBody);
    print(curlCommand);
    // print curl -x  dynamically for each request

    // print(encodedBody);
    http.Response response;

    if (method == 'GET') {
      response =
          await http.get(Uri.parse(fullUrl), headers: headers).timeout(timeout);
    } else if (method == 'POST') {
      response = await http
          .post(
            Uri.parse(fullUrl),
            headers: headers,
            body: encodedBody,
          )
          .timeout(timeout);
    } else {
      throw ApiException('Method $method not supported');
    }

    // print('Response Status Code: ${response.body}');
    // print('Response Headers: ${response.headers}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return null; // Return null for empty responses
      }
      try {
        return jsonDecode(response.body);
      } on FormatException catch (_) {
        throw ApiException(
            'Invalid JSON response', response.statusCode, response.body);
      }
    } else {
      throw ApiException('Server error', response.statusCode, response.body);
    }
  } on SocketException catch (e) {
    throw ApiException('Network error: ${e.message}');
  } on TimeoutException catch (_) {
    throw ApiException('Request timed out');
  } catch (e) {
    throw ApiException('Unexpected error: $e');
  }
}

Future<String> uploadImage(File imageFile) async {
  final String endpoint = '/uploadImageFile';
  final String method = 'POST';

  try {
    var request = http.MultipartRequest(method, Uri.parse('$hostUrl$endpoint'));
    request.files.add(await http.MultipartFile.fromPath(
        'imageFile', imageFile.path,
        contentType: MediaType('image', 'png')));
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);
      print(jsonResponse);
      if (jsonResponse['success'] == 1) {
        return jsonResponse['data']['imageUrl'];
      } else {
        throw ApiException(
            'Failed to upload image: ${jsonResponse['message']}');
      }
    } else {
      throw ApiException('Server error', response.statusCode,
          await response.stream.bytesToString());
    }
  } catch (e) {
    throw ApiException('Error uploading image: $e');
  }
}
