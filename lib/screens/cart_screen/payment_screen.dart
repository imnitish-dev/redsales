import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/provider/cart_provider.dart';
import 'package:twocliq/provider/customer_profile_provider.dart';
import 'package:twocliq/screens/cart_screen/widgets/checkout_footer_widget.dart';
import 'package:twocliq/screens/cart_screen/widgets/voucher_widget.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/my_profile_screen.dart';
import 'package:twocliq/screens/profile_screen/profile_screen.dart';

import '../../helper/animatedPage.dart';
import '../../models/customer_profile_model.dart';
import '../../services/customer_profile_service.dart';
import '../product_detail_screen/product_detail_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
    setAddressData();
  }

  String? selectedAddressID;
  Address? currentSelectedAddress;
  bool isPaid = false;

  void setAddressData() {

    logInfo("heuhe");



    var profileProvider = Provider.of<CustomerProfileProvider>(context, listen: false);


    final addresses = profileProvider.customerProfile?.addresses;

    logInfo("listOfAddress : $addresses");

    if (addresses != null && addresses.isNotEmpty) {

      selectedAddressID = addresses.first.addressId;

      currentSelectedAddress = profileProvider.customerProfile?.addresses?.firstWhere((element) {
        return element.addressId == selectedAddressID;
      });



      logInfo("currentSelectedAddress : $currentSelectedAddress");




     /* final city = currentSelectedAddress?.city;
      if (city != null && city.isNotEmpty) {
        setState(() {
          addressInfo.city = city;
        });
      }*/

     /* final address = currentSelectedAddress?.address;
      if (address != null && address.isNotEmpty) {
        setState(() {
          addressInfo.address = address;
        });
      }*/

    /*  final state = currentSelectedAddress?.state;
      if (state != null && state.isNotEmpty) {
        setState(() {
          addressInfo.state = state;
        });
      }*/

    /*  final pinCode = currentSelectedAddress?.pincode;
      if (pinCode != null && pinCode.isNotEmpty) {
        setState(() {
          addressInfo.pinCode = pinCode;
        });
      }*/

    }



  }

 /* AddressInfo addressInfo = AddressInfo(
      // title: "Shipping Address",
      // details: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
      );*/

  ContactInfo contactInfo = ContactInfo(
    phone: "+91- 97704-09874",
    email: "amandegar213@gmail.com",
  );




  String selectedPaymentMethod = "COD";

  void updateAddress(Address newAddress) {
    setState(() {
      currentSelectedAddress = newAddress;
    });
  }

  void updateContact(ContactInfo newContact) {
    setState(() {
      contactInfo = newContact;
    });
  }





  void changePaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customSizedBox(height: 20.h),
            Text(
              "Payment",
              style: customTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            customSizedBox(height: 10.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    AddressWidget(
                      addressInfo: currentSelectedAddress,
                      onEdit: updateAddress,
                    ),
                    customSizedBox(height: 12.h),
                    ContactWidget(
                      contactInfo: contactInfo,
                      onEdit: updateContact,
                    ),
                    customSizedBox(height: 20.h),
                    const CartItemsSection(),
                    customSizedBox(height: 20.h),
                     const VoucherWidget(),
                    customSizedBox(height: 20.h),
                    PaymentMethodWidget(
                      selectedMethod: selectedPaymentMethod,
                      onChange: changePaymentMethod,
                    ),
                    customSizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
             CheckoutFooter(selectedAddress: currentSelectedAddress),
          ],
        ),
      ),
    );
  }
}



class CartItemsSection extends StatefulWidget {
  const CartItemsSection({
    super.key,
  });

  @override
  State<CartItemsSection> createState() => _CartItemsSectionState();
}

class _CartItemsSectionState extends State<CartItemsSection> {




  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header: Items + Add Voucher
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Items",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      "${cartProvider.cartList?.cartProducts.length}",
                      style: customTextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// Cart List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartProvider.cartList?.cartProducts.length,
            itemBuilder: (context, index) {
              final item = cartProvider.cartList?.cartProducts[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Circular Product Image with Quantity Badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // soft black shadow
                                blurRadius: 6, // how soft the shadow looks
                                spreadRadius: 1, // how far the shadow spreads
                                offset: const Offset(0, 3), // position of shadow (x, y)
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 32.r,
                              backgroundImage: NetworkImage(item?.productImage??""),
                              onBackgroundImageError: (_, __) => const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -1.r,
                          bottom: -1.r,
                          child: Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.pink, width: 1.5),
                            ),
                            child: Center(
                              child: Text(
                                "${item?.quantity==null? "" : item?.quantity.toString()}",
                                style: customTextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),

                    /// Description
                    Expanded(
                      child: Text(
                        item?.productTitle??'',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black.withOpacity(0.8)),
                      ),
                    ),

                    /// Price
                    Text(
                      item?.total?.toString() ?? "",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AddressInfo {
   String? addressType;
   String? address;
   String? area;
   String? landmark;
   String? pinCode;
   String? state;
   String? city;

  AddressInfo(
      {
         this.addressType,
       this.address,
       this.state,
       this.area,
       this.landmark,
       this.pinCode,
       this.city});

  AddressInfo copyWith(
      {String? addressType,
      String? address,
      String? area,
      String? landmark,
      String? pinCode,
      String? state,
      String? city}) {
    return AddressInfo(
        address: address ?? this.address,
        addressType: addressType ?? this.addressType,
        area: area ?? this.area,
        landmark: landmark ?? this.landmark,
        pinCode: pinCode ?? this.pinCode,
        state: state ?? this.state,
        city: city ?? this.city);
  }
}

class ContactInfo {
  final String phone;
  final String email;

  ContactInfo({required this.phone, required this.email});

  ContactInfo copyWith({String? phone, String? email}) {
    return ContactInfo(
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}



class AddressWidget extends StatelessWidget {
  final Address? addressInfo;
  final ValueChanged<Address> onEdit;

  const AddressWidget({
    super.key,
    required this.addressInfo,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Shipping Address", style: customTextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Text(addressInfo?.address??"", style: customTextStyle(fontSize: 13.sp)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.pink),
              onPressed: () async {
                final updatedAddress = await _showEditAddressModal(
                  context,
                 // addressInfo,
                );
                if (updatedAddress != null) {
                  onEdit(updatedAddress);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<Address?> _showEditAddressModal(BuildContext context) async {
    final profileProvider = Provider.of<CustomerProfileProvider>(context, listen: false);
    final addresses = profileProvider.customerProfile?.addresses ?? [];

    Address? selectedAddress = addresses.isNotEmpty ? addresses.first : null;

    return await showModalBottomSheet<Address>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    customSizedBox(height: 20.h),

                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select Address",
                            style: customTextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    customSizedBox(height: 10.h),

                    // Address List
                    if (addresses.isNotEmpty)
                      Flexible(
                        child:
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            final address = addresses[index];
                            final isSelected = selectedAddress?.addressId == address.addressId;

                            return GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  selectedAddress = address;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: isSelected ? Colors.pink : Colors.grey.shade300,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r), // Clip actual content
                                  child: Container(
                                    color: Colors.grey.shade50,
                                    padding: EdgeInsets.all(12.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          address.addressType ?? "Home",
                                          style: customTextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                        ),
                                        customSizedBox(height: 4.h),
                                        Text(
                                          "${address.address}, ${address.area}, ${address.city} - ${address.pincode}",
                                          style: customTextStyle(fontSize: 14.sp, color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );





                            return GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  selectedAddress = address; // update selected
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: isSelected ? Colors.pink : Colors.grey.shade300,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      address.addressType ?? "Home",
                                      style: customTextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "${address.address}, ${address.area}, ${address.city} - ${address.pincode}",
                                      style: customTextStyle(fontSize: 14.sp, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    else
                      Center(child: Text("No addresses found", style: customTextStyle(color: Colors.grey))),

                    customSizedBox(height: 16.h),

                    // Confirm Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.pop(context, selectedAddress); // Return selected address
                        },
                        child: Text(
                          "Use This Address",
                          style: customTextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),


                    customSizedBox(height: 28.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

}

class ContactWidget extends StatelessWidget {
  final ContactInfo contactInfo;
  final ValueChanged<ContactInfo> onEdit;

  const ContactWidget({
    super.key,
    required this.contactInfo,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<CustomerProfileProvider>(context);
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact Information", style: customTextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp)),
                  customSizedBox(height: 4.h),
                  Text(profileProvider.customerProfile?.customerDetails?.contactNo??"", style: customTextStyle(fontWeight: FontWeight.normal,fontSize: 14.sp)),
                  customSizedBox(height: 4.h),
                  Text(profileProvider.customerProfile?.customerDetails?.emailId??"", style: customTextStyle(fontSize: 14.sp)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.pink),
              onPressed: () {
               /* onEdit(contactInfo.copyWith(phone: "+91-99999-00000"));*/
                Navigator.of(context).push(openAnimatedPage(const MyProfileScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}


class PaymentMethodWidget extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String> onChange;

  const PaymentMethodWidget({
    super.key,
    required this.selectedMethod,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final methods = ['COD', "Card", "UPI", "Net Banking", ];

    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          customSizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 12.w,
                children: methods.map((method) {
                  final isSelected = selectedMethod == method;

                  return GestureDetector(
                    onTap: () {
                      onChange(method);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink.shade50 : Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected ? Colors.pink : Colors.grey.shade300.withOpacity(0.4),
                          width: 0.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.pink.withOpacity(0.01),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        method,
                        style: TextStyle(
                          color: isSelected ? Colors.pink : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
