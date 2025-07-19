import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twocliq/screens/sign_in_screen.dart';

import '../helper/apirequest.dart';
import '../helper/constants.dart';
import 'main_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SessionService _sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    _checkSession();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }

  Future<void> _checkSession() async {
    try {
      // Check internet connection first
      final isConnected = await checkNetConnectivity();

      if (!mounted) return;

      if (!isConnected) {
        _showErrorDialog(context, 'Internet not found. Please check your connection.');
        return; // Stop further execution
      }

      // Proceed only if connected
      final isLoggedIn = await _sessionService.startSession();

      if (!mounted) return;

      if (isLoggedIn == true) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MainHomeScreen()),
              (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const SignInScreen()),
              (route) => false,
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog(context, 'An unexpected error occurred: $e');
    }
  }


/*  Future<void> _checkSession() async {
    try {
      final isLoggedIn = await _sessionService.startSession();

      if (!mounted) return;

      if (isLoggedIn == true) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const SignInScreen()),
              (route) => false,
        );
      }
    } catch (e) {
      if (!mounted) return;

      _showErrorDialog(context, 'An unexpected error occurred: $e');
    }
  }*/

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              _checkSession();
              Navigator.of(context).pop();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kPrimaryColor.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
          ),
          // Decorative circles
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor.withOpacity(0.1),
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                customSizedBox(height: 30.h),
                // CircularProgressIndicator(
                //   valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SessionService {
  Future<bool?> startSession() async {
    final response = await makeApiCall(
      endpoint: "/customer/startSession",
      method: 'POST',
    );

    if (response is Map<String, dynamic>) {
      if (response['success'] == 0) {
        return false; // Not logged in
      } else if (response['success'] == 1) {
        // Save user data
        final prefs = await SharedPreferences.getInstance();
        String jsonString = jsonEncode(response['data']);
        await prefs.setString('userInfo', jsonString);
        return true; // Logged in
      }
    }

    throw Exception('Unexpected API response');
  }
}