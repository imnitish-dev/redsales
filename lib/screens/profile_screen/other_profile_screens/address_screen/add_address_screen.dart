import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../helper/constants.dart';
import '../../../../provider/customer_profile_provider.dart';
import '../../../../services/customer_profile_service.dart';
import '../../../auth_screens/widgets/address_type_selector.dart';
import '../../../auth_screens/widgets/state_selector_widget.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  final addressController = TextEditingController();
  final GlobalKey<FormState> addressKey = GlobalKey<FormState>();

  final areaController = TextEditingController();
  final GlobalKey<FormState> areaKey = GlobalKey<FormState>();

  final landmarkController = TextEditingController();
  final GlobalKey<FormState> landmarkKey = GlobalKey<FormState>();

  final pinCodeController = TextEditingController();
  final GlobalKey<FormState> pinCodeKey = GlobalKey<FormState>();

  final cityController = TextEditingController();
  final GlobalKey<FormState> cityKey = GlobalKey<FormState>();

  final stateController = TextEditingController();
  final GlobalKey<FormState> stateKey = GlobalKey<FormState>();

  bool isUpdateLoading = false;
  bool isDeleteLoading = false;
  String? selectedState;
  String? selectedAddressType;

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<CustomerProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              customSizedBox(height: 20.h),
              Center(
                child: Text(
                  "Add New Address",
                  style: customTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ),
              customSizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  children: [
                    AppTextField(
                        controller: addressController,
                        customKeyboardType: TextInputType.text,
                        formKey: addressKey,
                        label: 'Address',
                        canBeEmpty: false),
                    customSizedBox(height: 15.h),
                    AppTextField(
                        controller: areaController,
                        customKeyboardType: TextInputType.text,
                        formKey: areaKey,
                        label: 'Area',
                        canBeEmpty: false),
                    customSizedBox(height: 15.h),
                    AppTextField(
                        controller: landmarkController,
                        customKeyboardType: TextInputType.text,
                        formKey: landmarkKey,
                        label: 'Landmark',
                        canBeEmpty: true),
                    customSizedBox(height: 15.h),
                    AppTextField(
                        controller: pinCodeController,
                        customKeyboardType: TextInputType.number,
                        formKey: pinCodeKey,
                        label: 'Pin Code',
                        canBeEmpty: false),
                    customSizedBox(height: 15.h),
                    AppTextField(
                        controller: cityController,
                        customKeyboardType: TextInputType.text,
                        formKey: cityKey,
                        label: 'City/Town',
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
                                    text: "Address Type ",
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
                    AddressTypeSelector(
                      selectedAddress: selectedAddressType,
                      onChanged: (value) {
                        setState(() {
                          selectedAddressType = value;
                        });
                      },
                    ),



                    customSizedBox(height: 35.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () async {

                          bool allFormsValid = validateAllForms([
                            addressKey,
                            areaKey,
                            landmarkKey,
                            pinCodeKey,
                            cityKey,
                            stateKey,
                          ]);

                          if (!allFormsValid) {
                            showErrorToast(msg: "please enter all fields..");
                            return;
                          }

                          if (selectedState == null) {
                            showErrorToast(msg: "please enter state..");
                            return;
                          }

                          if (selectedAddressType == null) {
                            showErrorToast(msg: "please enter Address Type..");
                            return;
                          }



                          logInfo("ready to go!");

                          setState(() {
                            isUpdateLoading = true;
                          });


                          bool isAddressAdded = await CustomerService.addCustomerAddress(
                              addressType: selectedAddressType!,
                              address: addressController.text,
                              area: areaController.text,
                              landmark: landmarkController.text,
                              pincode: pinCodeController.text,
                              city: cityController.text,
                              state: selectedState!
                          );

                          if(isAddressAdded){
                            bool refreshProfile =  await userProfileProvider.loadProfileData();
                            if(refreshProfile){
                              showCustomToast(msg: "address updated!");
                              Navigator.pop(context);
                            }else{
                              showErrorToast(msg: "failed to update address..");
                            }
                          }else{
                            showErrorToast(msg: "failed to update address..");
                          }

                          setState(() {
                            isUpdateLoading = false;
                          });

                        },
                        child :  isUpdateLoading ? Center(

                          child: SizedBox(
                            width: 20.r,
                            height: 20.r,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),

                        )  :Text(
                          "Save Changes",
                          style: customTextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    customSizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
