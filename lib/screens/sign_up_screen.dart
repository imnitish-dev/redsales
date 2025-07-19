import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> businessNameKey = GlobalKey<FormState>();
  final TextEditingController businessNameController = TextEditingController();

  final GlobalKey<FormState> businessPhoneNumberKey = GlobalKey<FormState>();
  final TextEditingController businessPhoneNumberController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customSizedBox(height: 20.h),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(FeatherIcons.chevronLeft)),
                        ],
                      ),
                      customSizedBox(height: 10.h),
                      Text('Signup', style: customTextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                      customSizedBox(height: 20.h),
                      Text(
                        "Your journey begins here. Create your account and take the first step.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey, height: 1.4),
                      ),
                      customSizedBox(height: 40.h),
                      AppTextField(
                        formKey: businessNameKey,
                        controller: businessNameController,
                        label: 'Business Name',
                        hint: 'Enter Your Business Name',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.text,
                        canBeEmpty: false,
                      ),
                      customSizedBox(height: 35.h),
                      AppTextField(
                        formKey: businessPhoneNumberKey,
                        controller: businessPhoneNumberController,
                        label: 'Business Phone Number',
                        hint: 'Enter Phone Number',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.text,
                        canBeEmpty: false,
                      ),
                      customSizedBox(height: 35.h),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: GestureDetector(
                onTap: () {
                  if (isLoading) {
                    return;
                  } else {

                    setState(() {
                      isLoading = true;
                    });

                    Future.delayed(const Duration(seconds: 1), () {
                      print("hehe");
                      setState(() {
                        isLoading = false;
                      });
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  decoration:
                      const BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.all(Radius.circular(22))),
                  child: Padding(
                    padding: EdgeInsets.all(15.r),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text('Create Account', style: customTextStyle(fontSize: 18.sp, color: Colors.white)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
