import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twocliq/helper/user_shared_pref.dart';
import 'package:twocliq/screens/auth_screens/register_screen.dart';
import 'package:twocliq/screens/auth_screens/sign_up_screen.dart';

import '../../helper/apirequest.dart';
import '../../helper/constants.dart';
import '../main_home_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _userNameError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(_onUserNameChanged);
    _passwordController.addListener(_onPasswordChanged);
    _userNameController.text = "9545688916";
    _passwordController.text = "test1234";
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onUserNameChanged() {
    final newError = _validateUserName(_userNameController.text);
    if (newError != _userNameError) {
      setState(() => _userNameError = newError);
    }
  }

  void _onPasswordChanged() {
    final newError = _validatePassword(_passwordController.text);
    if (newError != _passwordError) {
      setState(() => _passwordError = newError);
    }
  }



  Future<void> _submit(BuildContext context) async {

    bool checkNet = await checkNetConnectivity();
    if(!checkNet){
      showErrorToast(msg: "internet connection not found!");
      return;
    }

    final userNameError = _validateUserName(_userNameController.text);
    final passwordError = _validatePassword(_passwordController.text);

    setState(() {
      _userNameError = userNameError;
      _passwordError = passwordError;
    });

    if (userNameError != null || passwordError != null) return;

    setState(() => _isLoading = true);

    try {
      final rawResponse = await makeApiCall(
        endpoint: '/customer/login',
        method: 'POST',
        body: {
          'userName': _userNameController.text.trim(),
          'password': _passwordController.text,
        },
      );

      if (rawResponse != null) {
        final loginResponse = LoginResponse.fromJson(rawResponse);

        if (loginResponse.success == 1 && loginResponse.data != null) {
          // Save session using the helper
          await UserSharedPref.saveUserSession(
            loginResponse.data!.loginToken,
            loginResponse.data!.loggedIn.userDetails,
          );



          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MainHomeScreen()),
                (route) => false,
          );
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loginResponse.message.isNotEmpty
                  ? loginResponse.message
                  : 'Login failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String? _validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your username';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _showForgotPasswordDialog() {
    final forgotPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Forgot Password', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enter your username to reset your password:',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
            SizedBox(height: 16.h),
            TextFormField(
              controller: forgotPasswordController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (forgotPasswordController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please enter your username'),
                  backgroundColor: Colors.red,
                ));
                return;
              }
              try {

                bool checkNet = await checkNetConnectivity();
                if(!checkNet){
                  showErrorToast(msg: "internet connection not found!");
                  return;
                }

                final response = await makeApiCall(
                  endpoint: '/customer/forgot-password',
                  method: 'POST',
                  body: {'userName': forgotPasswordController.text.trim()},
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(response?['message'] ?? 'Request processed'),
                  backgroundColor: response?['success'] == 1 ? Colors.green : Colors.red,
                  behavior: SnackBarBehavior.floating,
                ));
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Error: $e'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
            child: Text('Reset', style: TextStyle(color: Colors.white, fontSize: 17.sp)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: Colors.grey[600]))),
            ],
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customSizedBox(height: 60.h),
                Text('Login', style: customTextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                customSizedBox(height: 16.h),
                Text(
                  "Welcome back! Let's get you signed in.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey, height: 1.4),
                ),
                customSizedBox(height: 40.h),

                // User name field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('User Name', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                ),
                customSizedBox(height: 8.h),
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your User Name',
                    hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    errorText: _userNameError,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  ),
                ),
                customSizedBox(height: 24.h),

                // Password field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Password', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                ),
                customSizedBox(height: 8.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    errorText: _passwordError,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, size: 20.sp),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                customSizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _showForgotPasswordDialog,
                    child: Text('Forgot Password?', style: TextStyle(fontSize: 14.sp, color: kPrimaryColor)),
                  ),
                ),
                customSizedBox(height: 32.h),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : () => _submit(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: _isLoading
                        ? SizedBox(height: 20.h, width: 20.w, child: CircularProgressIndicator(strokeWidth: 2.w, valueColor: const AlwaysStoppedAnimation(Colors.white)))
                        : Text('Login', style: customTextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
                customSizedBox(height: 60.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: customTextStyle(fontSize: 14.sp, color: Colors.grey)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
                      },
                      child: Text('CREATE ACCOUNT', style: customTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: kPrimaryColor)),
                    ),
                  ],
                ),
                customSizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class LoginResponse {
  final int success;
  final String message;
  final LoginData? data;

  LoginResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final String loginToken;
  final LoggedIn loggedIn;

  LoginData({
    required this.loginToken,
    required this.loggedIn,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      loginToken: json['loginToken'] ?? '',
      loggedIn: LoggedIn.fromJson(json['loggedIn'] ?? {}),
    );
  }
}

class LoggedIn {
  final bool status;
  final UserDetails userDetails;

  LoggedIn({
    required this.status,
    required this.userDetails,
  });

  factory LoggedIn.fromJson(Map<String, dynamic> json) {
    return LoggedIn(
      status: json['status'] ?? false,
      userDetails: UserDetails.fromJson(json['userDetails'] ?? {}),
    );
  }
}

class UserDetails {
  final String customerName;
  final String storeName;
  final String contactNo;
  final String emailId;
  final String profileIcon;
  final String kycStatus;
  final String whatsappNo;
  final String customerId;

  UserDetails({
    required this.customerName,
    required this.storeName,
    required this.contactNo,
    required this.emailId,
    required this.profileIcon,
    required this.kycStatus,
    required this.whatsappNo,
    required this.customerId,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      customerName: json['customerName'] ?? '',
      storeName: json['storeName'] ?? '',
      contactNo: json['contactNo'] ?? '',
      emailId: json['emailId'] ?? '',
      profileIcon: json['profileIcon'] ?? '',
      kycStatus: json['kycStatus'] ?? '',
      whatsappNo: json['whatsappNo'] ?? '',
      customerId: json['customerId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'customerName': customerName,
    'storeName': storeName,
    'contactNo': contactNo,
    'emailId': emailId,
    'profileIcon': profileIcon,
    'kycStatus': kycStatus,
    'whatsappNo': whatsappNo,
    'customerId': customerId,
  };
}
