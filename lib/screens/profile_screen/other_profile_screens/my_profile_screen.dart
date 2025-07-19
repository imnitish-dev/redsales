import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                    SizedBox(width: 4.w),
                    Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                customSizedBox(height: 16.h),

                // Form Fields
                _buildLabel("Business Name"),
                customSizedBox(height: 8.h),
                _buildTextField("Enter Your Business Name"),
                customSizedBox(height: 12.h),

                _buildLabel("Business Phone Number"),
                customSizedBox(height: 8.h),
                _buildTextField("Enter Phone Number"),
                customSizedBox(height: 12.h),

                _buildLabel("Business Type"),
                customSizedBox(height: 8.h),
                _buildDropdown(["Retail", "Wholesale", "Service"]),
                customSizedBox(height: 12.h),

                _buildLabel("Phone Number"),
                customSizedBox(height: 8.h),
                _buildTextField("Enter Your Phone Number"),
                customSizedBox(height: 12.h),

                _buildLabel("Whatsapp Number"),
                customSizedBox(height: 8.h),
                _buildTextField("Enter Your Whatsapp Number"),
                customSizedBox(height: 12.h),

                _buildLabel("Email Address"),
                customSizedBox(height: 8.h),
                _buildTextField("Enter Your Email Address"),
                customSizedBox(height: 12.h),

                _buildLabel("Password"),
                customSizedBox(height: 8.h),
                _buildTextField("Enter Your Password", isPassword: true),
                customSizedBox(height: 12.h),

                _buildLabel("Address"),
                customSizedBox(height: 8.h),
                _buildTextField("Enter Your Address"),
                customSizedBox(height: 12.h),

                _buildLabel("Aadhar Card Number"),
                customSizedBox(height: 8.h),
                _buildTextField("Enter Your Aadhar Card Number"),
                customSizedBox(height: 12.h),

                _buildLabel("PAN/Udyam/GST"),
                customSizedBox(height: 8.h),
                _buildTextField("No Input", isEnabled: false),
                customSizedBox(height: 12.h),

                _buildLabel("PAN/Udyam/GST Upload"),
                customSizedBox(height: 8.h),
                _buildMultilineField(""),
                customSizedBox(height: 20.h),

                // Submit Button
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
