import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/constants.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> enterpriseOrStoreNameKey = GlobalKey<FormState>();
  final TextEditingController enterpriseOrStoreNameController = TextEditingController();

  final GlobalKey<FormState> contactNumberKey = GlobalKey<FormState>();
  final TextEditingController contactNumberController = TextEditingController();

  final GlobalKey<FormState> whatsappNumberKey = GlobalKey<FormState>();
  final TextEditingController whatsappNumberController = TextEditingController();

  final GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> addressLine1Key = GlobalKey<FormState>();
  final TextEditingController addressLine1Controller = TextEditingController();

  final GlobalKey<FormState> addressLine2Key = GlobalKey<FormState>();
  final TextEditingController addressLine2Controller = TextEditingController();

  final GlobalKey<FormState> cityKey = GlobalKey<FormState>();
  final TextEditingController cityController = TextEditingController();

  final GlobalKey<FormState> pinCodeKey = GlobalKey<FormState>();
  final TextEditingController pinCodeController = TextEditingController();

  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String? selectedState;

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
                  physics: const BouncingScrollPhysics(),
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
                        formKey: nameKey,
                        controller: nameController,
                        label: 'Name',
                        hint: 'Enter Name',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.text,
                        canBeEmpty: false,
                      ),
                      customSizedBox(height: 35.h),
                      AppTextField(
                        formKey: enterpriseOrStoreNameKey,
                        controller: enterpriseOrStoreNameController,
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
                        formKey: contactNumberKey,
                        controller: contactNumberController,
                        label: 'Business Phone Number',
                        hint: 'Enter Phone Number',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.phone,
                        canBeEmpty: false,
                        textLimit: 10,
                      ),
                      customSizedBox(height: 35.h),
                      AppTextField(
                        formKey: whatsappNumberKey,
                        controller: whatsappNumberController,
                        label: 'WhatsApp Number',
                        hint: 'Enter WhatsApp Number',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.phone,
                        canBeEmpty: false,
                        textLimit: 10,
                      ),
                      customSizedBox(height: 35.h),
                      AppTextField(
                        formKey: emailKey,
                        controller: emailController,
                        label: 'Email',
                        hint: 'Enter Email',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.emailAddress,
                        canBeEmpty: false,
                      ),
                      customSizedBox(height: 35.h),
                      AppTextField(
                        formKey: passwordKey,
                        controller: passwordController,
                        label: 'Password',
                        hint: 'Enter Password',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.visiblePassword,
                        canBeEmpty: false,
                      ),
                      customSizedBox(height: 35.h),
                      AppTextField(
                        formKey: addressLine1Key,
                        controller: addressLine1Controller,
                        label: 'Address Line 1',
                        hint: 'Enter Address Line 1',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.text,
                        canBeEmpty: false,
                      ),
                      customSizedBox(height: 35.h),
                      AppTextField(
                        formKey: addressLine2Key,
                        controller: addressLine2Controller,
                        label: 'Address Line 2',
                        hint: 'Enter Address Line 2',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.text,
                        canBeEmpty: false,
                      ),
                      customSizedBox(height: 35.h),
                      AppTextField(
                        formKey: cityKey,
                        controller: cityController,
                        label: 'City',
                        hint: 'Enter City',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.text,
                        canBeEmpty: false,
                      ),
                      customSizedBox(height: 35.h),
                      AppTextField(
                        formKey: pinCodeKey,
                        controller: pinCodeController,
                        label: 'Pin Code',
                        hint: 'Enter Pin Code',
                        labelTextStyle:
                            customTextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        textFieldStyle: customTextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        customKeyboardType: TextInputType.number,
                        canBeEmpty: false,
                      ),
                      customSizedBox(height: 35.h),
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
                      customSizedBox(height: 05.h),
                      StateSelector(
                        selectedState: selectedState,
                        onChanged: (value) {
                          setState(() {
                            selectedState = value;
                          });
                        },
                      ),
                      customSizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: GestureDetector(
                onTap: () async {
                  if (isLoading) {
                    showCustomToast(msg: "please wait..");
                    return;
                  } else {
                    bool allFormsValid = validateAllForms([
                      contactNumberKey,
                      nameKey,
                      enterpriseOrStoreNameKey,
                      emailKey,
                      passwordKey,
                      whatsappNumberKey,
                      addressLine1Key,
                      addressLine2Key,
                      cityKey,
                      pinCodeKey,
                    ]);

                    if (!allFormsValid) {
                      showErrorToast(msg: "please enter all fields..");
                      return;
                    }

                    if (selectedState == null) {
                      showErrorToast(msg: "please enter state..");
                      return;
                    }

                    logInfo("lessgo");

                    showCustomToast(msg: "please wait..");
                    setState(() {
                      isLoading = true;
                    });
                    final isSuccess = await AuthServices.customerRegistration(
                      contactNo: contactNumberController.text,
                      name: nameController.text,
                      enterpriseName: enterpriseOrStoreNameController.text,
                      emailId: emailController.text,
                      password: passwordController.text,
                      whatsappNo: whatsappNumberController.text,
                      addressLine1: addressLine1Controller.text,
                      addressLine2: addressLine2Controller.text,
                      city: cityController.text,
                      pinCode: pinCodeController.text,
                      storeName: enterpriseOrStoreNameController.text,
                      state: selectedState!,
                    );

                    setState(() {
                      isLoading = false;
                    });

                    if (isSuccess) {
                      showCustomToast(msg: "Registration Successful");
                      Navigator.pop(context);
                    }
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

class StateSelector extends StatelessWidget {
  final String? selectedState;
  final ValueChanged<String?> onChanged;

  const StateSelector({super.key, required this.selectedState, required this.onChanged});

  static const List<String> indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedState,
      items: indianStates.map((state) => DropdownMenuItem(value: state, child: Text(state))).toList(),
      onChanged: onChanged,
      dropdownColor: Colors.white,
      style: customTextStyle(color: Colors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.6), width: 0.8),
        ),
        /*focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.pink, width: 1.2),
        ),*/
      ),
    );
  }
}
