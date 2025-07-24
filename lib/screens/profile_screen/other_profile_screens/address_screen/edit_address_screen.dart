import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/helper/address_types_list.dart';
import 'package:twocliq/helper/indian_states_list.dart';

import '../../../../helper/constants.dart';
import '../../../../models/customer_profile_model.dart';
import '../../../../provider/customer_profile_provider.dart';
import '../../../../services/customer_profile_service.dart';
import '../../../auth_screens/sign_up_screen.dart';
import '../../../auth_screens/widgets/address_type_selector.dart';
import '../../../auth_screens/widgets/state_selector_widget.dart';

class EditAddressScreen extends StatefulWidget {
  final Address currentAddress;
  const EditAddressScreen({super.key, required this.currentAddress});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
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
  void initState() {
    if (widget.currentAddress.address != null || widget.currentAddress.address!.isNotEmpty) {
      addressController.text = widget.currentAddress.address!;
    }
    if (widget.currentAddress.area != null || widget.currentAddress.area!.isNotEmpty) {
      areaController.text = widget.currentAddress.area!;
    }
    if (widget.currentAddress.landmark != null || widget.currentAddress.landmark!.isNotEmpty) {
      landmarkController.text = widget.currentAddress.landmark!;
    }

    if (widget.currentAddress.pincode != null || widget.currentAddress.pincode!.isNotEmpty) {
      pinCodeController.text = widget.currentAddress.pincode!;
    }

    if (widget.currentAddress.city != null || widget.currentAddress.city!.isNotEmpty) {
      cityController.text = widget.currentAddress.city!;
    }

    if (indianStates.contains(widget.currentAddress.state)) {
      setState(() {
        selectedState = widget.currentAddress.state;
      });
    }

    if(addressTypes.contains(widget.currentAddress.addressType)){
      setState(() {
        selectedAddressType = widget.currentAddress.addressType;
      });
    }

    super.initState();
  }

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
                  "Edit Address",
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

                          if(widget.currentAddress.addressId==null){
                            showErrorToast(msg: "something went wrong");
                            return;
                          }

                          logInfo("ready to go!");

                          setState(() {
                            isUpdateLoading = true;
                          });


                          bool isChangePushed = await CustomerService.updateCustomerAddress(
                              addressId: widget.currentAddress.addressId!,
                              addressType: selectedAddressType!,
                              address: addressController.text,
                              area: areaController.text,
                              landmark: landmarkController.text,
                              pincode: pinCodeController.text,
                              city: cityController.text,
                              state: selectedState!);

                          if(isChangePushed){
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
                    SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Colors.redAccent, width: 0.5), // red border
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isDeleteLoading = true;
                            });



                            if(widget.currentAddress.addressId==null){
                              showErrorToast(msg: "something went wrong!");
                              return;
                            }

                            bool isChangePushed = await CustomerService.deleteCustomerAddress(
                            addressId: widget.currentAddress.addressId!
                            );

                            if(isChangePushed){
                              bool refreshProfile =  await userProfileProvider.loadProfileData();
                              if(refreshProfile){
                                showCustomToast(msg: "address deleted!");
                                Navigator.pop(context);
                              }else{
                                showErrorToast(msg: "failed to update address..");
                              }
                            }else{
                              showErrorToast(msg: "failed to update address..");
                            }

                            setState(() {
                              isDeleteLoading = false;
                            });
                          },
                          child:  isDeleteLoading ? Center(

                            child: SizedBox(
                              width: 20.r,
                              height: 20.r,
                              child: const CircularProgressIndicator(
                                color: Colors.pinkAccent,
                              ),
                            ),

                          )  : Text(
                            "Delete Address",
                            style: customTextStyle(
                              fontSize: 16.sp,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
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
