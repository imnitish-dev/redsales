import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

import '../../auth_screens/widgets/state_selector_widget.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  final nameController = TextEditingController();
  final GlobalKey<FormState> nameKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();

  final enterpriseNameController = TextEditingController();
  final GlobalKey<FormState> enterpriseNameKey = GlobalKey<FormState>();

  final addressLine1Controller = TextEditingController();
  final GlobalKey<FormState> addressLine1Key = GlobalKey<FormState>();

  final addressLine2Controller = TextEditingController();
  final GlobalKey<FormState> addressLine2Key = GlobalKey<FormState>();

  final cityController = TextEditingController();
  final GlobalKey<FormState> cityKey = GlobalKey<FormState>();

  final pinCodeController = TextEditingController();
  final GlobalKey<FormState> pinCodeKey = GlobalKey<FormState>();

  String? selectedState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button + Title
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, size: 18),
                    ),
                    customSizedBox(width: 4.w),
                    Text(
                      "My Profile",
                      style: customTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                customSizedBox(height: 16.h),

                AppTextField(
                    controller: nameController,
                    customKeyboardType: TextInputType.text,
                    formKey: nameKey,
                    label: 'Name',
                    canBeEmpty: false),

                customSizedBox(height: 15.h),

                AppTextField(
                    controller: emailController,
                    customKeyboardType: TextInputType.text,
                    formKey: emailKey,
                    label: 'Email',
                    canBeEmpty: false),

                customSizedBox(height: 15.h),

                AppTextField(
                    controller: enterpriseNameController,
                    customKeyboardType: TextInputType.text,
                    formKey: enterpriseNameKey,
                    label: 'Enterprise Name',
                    canBeEmpty: false),

                customSizedBox(height: 15.h),

                AppTextField(
                    controller: addressLine1Controller,
                    customKeyboardType: TextInputType.text,
                    formKey: addressLine1Key,
                    label: 'Address Line 1',
                    canBeEmpty: false),

                customSizedBox(height: 15.h),

                AppTextField(
                    controller: addressLine2Controller,
                    customKeyboardType: TextInputType.text,
                    formKey: addressLine2Key,
                    label: 'Address Line 2',
                    canBeEmpty: false),

                customSizedBox(height: 15.h),

                AppTextField(
                    controller: cityController,
                    customKeyboardType: TextInputType.text,
                    formKey: cityKey,
                    label: 'City',
                    canBeEmpty: false),

                customSizedBox(height: 15.h),

                AppTextField(
                    controller: pinCodeController,
                    customKeyboardType: TextInputType.number,
                    formKey: pinCodeKey,
                    label: 'Pin Code',
                    canBeEmpty: false),

                customSizedBox(height: 15.h),

                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Row(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: customTextStyle(fontSize: 14, color: Colors.black54),
                          children: [
                            TextSpan(
                                text: "State ",
                                style: customTextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.black)),
                            TextSpan(
                                text: "*",
                                style: customTextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.redAccent))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                customSizedBox(height: 15.h),

                StateSelector(
                  selectedState: selectedState,
                  onChanged: (value) {
                    setState(() {
                      selectedState = value;
                    });
                  },
                ),


                customSizedBox(height: 25.h),


                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField(String hint,
      {bool isPassword = false, bool isEnabled = true}) {
    return TextField(
      enabled: isEnabled,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: customTextStyle(color: Colors.black54.withOpacity(0.7),fontSize: 16.sp),
        filled: true,
        fillColor: Colors.white,
        // fillColor: Colors.grey.shade100.withOpacity(0.4),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),

        // Add custom border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),   // Change to your desired color
            width: 0.4,             // Set thickness
          ),
        ),
      ),
    )
    ;
  }

   Widget _buildDropdown(List<String> options) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.grey.shade50, // Background color of opened menu
      style: customTextStyle(color: Colors.black, fontSize: 14.sp), // Text style for items
      iconEnabledColor: Colors.pink, // Icon color
      items: options
          .map((option) => DropdownMenuItem(
        value: option,
        child: Text(option,style: customTextStyle()),
      ))
          .toList(),
      onChanged: (_) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),
            width: 0.4,
          ),
        ),

      ),
    );
  }

  Widget _buildMultilineField(String hint) {
    return TextField(
      maxLines: 4,
      /*decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      )*/
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: customTextStyle(color: Colors.black54.withOpacity(0.7),fontSize: 16.sp),
        filled: true,
        fillColor: Colors.white,
        // fillColor: Colors.grey.shade100.withOpacity(0.4),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),

        // Add custom border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),   // Change to your desired color
            width: 0.4,             // Set thickness
          ),
        ),
      ),
    );
  }
}
