import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/provider/customer_profile_provider.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/address_screen/edit_address_screen.dart';

import '../../../../helper/animatedPage.dart';
import '../../../../helper/constants.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {



  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<CustomerProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            customSizedBox(height: 20.h),
            Center(
              child: Text(
                "Addresses",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            customSizedBox(height: 5.h),

            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: userProfileProvider.customerProfile?.addresses?.length,
                itemBuilder: (context, index) {
                  final address = userProfileProvider.customerProfile?.addresses?[index];
                 // final isSelected = selectedAddress?.addressId == address.addressId;
              
                  return GestureDetector(
                    onTap: () {
                     /* setModalState(() {
                        selectedAddress = address; // update selected
                      });*/
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Container(
                        //margin: EdgeInsets.symmetric(vertical: 8.h),
                        padding: EdgeInsets.all(22.r),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width:  0.4,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    address?.area ?? "Home",
                                    style: customTextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "${address?.address}, ${address?.area}, ${address?.city} - ${address?.pincode}",
                                    style: customTextStyle(fontSize: 14.sp, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(onPressed: (){
                              Navigator.of(context).push(openAnimatedPage(
                                  EditAddressScreen(currentAddress: address!)
                              ));
                            }, icon: Icon(FeatherIcons.edit2,size: 20.r))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
