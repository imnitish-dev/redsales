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

import '../../services/customer_profile_service.dart';

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

  void setAddressData() {
    var profileProvider = Provider.of<CustomerProfileProvider>(context, listen: false);
      final city = profileProvider.customerProfile?.address?.city;
      if (city != null && city.isNotEmpty) {
        setState(() {
          addressInfo.city = city;
        });
      }

    final address = profileProvider.customerProfile?.address?.address;
    if (address != null && address.isNotEmpty) {
      setState(() {
        addressInfo.address = address;
      });
    }

    final state = profileProvider.customerProfile?.address?.state;
    if (state != null && state.isNotEmpty) {
      setState(() {
        addressInfo.state = state;
      });
    }

    final pinCode = profileProvider.customerProfile?.address?.pinCode;
    if (pinCode != null && pinCode.isNotEmpty) {
      setState(() {
        addressInfo.pinCode = pinCode;
      });
    }

  }

  AddressInfo addressInfo = AddressInfo(
      // title: "Shipping Address",
      // details: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
      );

  ContactInfo contactInfo = ContactInfo(
    phone: "+91- 97704-09874",
    email: "amandegar213@gmail.com",
  );



  Voucher? selectedVoucher;
  String selectedPaymentMethod = "COD";

  void updateAddress(AddressInfo newAddress) {
    setState(() {
      addressInfo = newAddress;
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
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            customSizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    AddressWidget(
                      addressInfo: addressInfo,
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
             CheckoutFooter(),
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

class Voucher {
  final String code;
  final String description;
  final int discount;

  Voucher({required this.code, required this.description, required this.discount});
}

class AddressWidget extends StatelessWidget {
  final AddressInfo addressInfo;
  final ValueChanged<AddressInfo> onEdit;

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
                  Text("Shipping Address", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Text(addressInfo.address??"", style: TextStyle(fontSize: 13.sp)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.pink),
              onPressed: () async {
                final updatedAddress = await _showEditAddressModal(
                  context,
                  addressInfo,
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

  /// Opens modal to edit the address
  Future<AddressInfo?> _showEditAddressModal(BuildContext context, AddressInfo initialAddress) async {
    final addressController = TextEditingController(text: initialAddress.address);
    final areaController = TextEditingController(text: initialAddress.area);
    final landmarkController = TextEditingController(text: initialAddress.landmark);
    final cityController = TextEditingController(text: initialAddress.city);
    final pinCodeController = TextEditingController(text: initialAddress.pinCode);
    final stateController = TextEditingController(text: initialAddress.state);
    bool isLoading = false;

    return await showModalBottomSheet<AddressInfo>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping Address", style: customTextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  customSizedBox(height: 20.h),
                  DottedLine(
                    dashColor: Colors.grey.withOpacity(0.4),
                    dashLength: 5,
                    dashGapLength: 3,
                    lineThickness: 2,
                  ),

                  customSizedBox(height: 20.h),

                  // Country (read-only)
                  Text("Country", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
                  customSizedBox(height: 4.h),
                  Text("India", style: customTextStyle(color: Colors.grey, fontSize: 14.sp)),

                  customSizedBox(height: 12.h),
                  Text("Address", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
                  customSizedBox(height: 5.h),
                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),
                  customSizedBox(height: 18.h),



                  customSizedBox(height: 12.h),
                  Text("Area", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
                  customSizedBox(height: 5.h),
                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: TextField(
                      controller: areaController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),
                  customSizedBox(height: 18.h),

                  customSizedBox(height: 12.h),
                  Text("Landmark", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
                  customSizedBox(height: 5.h),
                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: TextField(
                      controller: landmarkController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),
                  customSizedBox(height: 18.h),





                  Text("Town / City", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
                  customSizedBox(height: 5.h),
                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: TextField(
                      controller: cityController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),

                  customSizedBox(height: 12.h),
                  Text("Postcode", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
                  customSizedBox(height: 5.h),
                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: TextField(
                      controller: pinCodeController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),
                  /*TextField(
                controller: postalController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
                ),
              ),*/

                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {

                        if(addressController.text.isNotEmpty && areaController.text.isNotEmpty && pinCodeController.text.isNotEmpty && cityController.text.isNotEmpty){

                          logInfo('addressType : "Home"');
                          logInfo('address : ${addressController.text}');
                          logInfo('area : ${areaController.text}');
                          logInfo('landmark : ${landmarkController.text}');
                          logInfo('pincode : ${pinCodeController.text}');
                          logInfo('city : ${cityController.text}');
                          logInfo('state : "Maharashtra"');



                          isLoading = await CustomerService.addCustomerAddress(
                            addressType: "Home",
                            address: addressController.text,
                            area: areaController.text,
                            landmark: landmarkController.text.isEmpty ? " " : landmarkController.text,
                            pincode: pinCodeController.text,
                            city: cityController.text,
                            state: "Maharashtra",
                          );



                          if(isLoading){
                            showCustomToast(msg: "address updated!");
                            Navigator.pop(
                                context,
                                initialAddress.copyWith(
                                    city: cityController.text,
                                    address: addressController.text,
                                    state: "Maharashtra",
                                    addressType: 'Home',
                                    area: areaController.text,
                                    landmark: landmarkController.text.isEmpty ? " " : landmarkController.text,
                                    pinCode: pinCodeController.text));
                          }else{
                            showCustomToast(msg: 'failed to update address');
                          }

                        }else{
                          showCustomToast(msg: "please fill all fields");
                        }


                      },
                      child: isLoading ? SizedBox(width: 5.r,height: 5.r,child: CircularProgressIndicator(color: Colors.white),) : Text("Save Changes",
                          style: customTextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        );
      },
    );


    return await showModalBottomSheet<AddressInfo>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping Address", style: customTextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              customSizedBox(height: 20.h),
              DottedLine(
                dashColor: Colors.grey.withOpacity(0.4),
                dashLength: 5,
                dashGapLength: 3,
                lineThickness: 2,
              ),

              customSizedBox(height: 20.h),

              // Country (read-only)
              Text("Country", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
              customSizedBox(height: 4.h),
              Text("India", style: customTextStyle(color: Colors.grey, fontSize: 14.sp)),

              customSizedBox(height: 12.h),
              Text("Address", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
              customSizedBox(height: 5.h),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none),
                ),
              ),
              customSizedBox(height: 18.h),



              customSizedBox(height: 12.h),
              Text("Area", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
              customSizedBox(height: 5.h),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: areaController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none),
                ),
              ),
              customSizedBox(height: 18.h),

              customSizedBox(height: 12.h),
              Text("Landmark", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
              customSizedBox(height: 5.h),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: landmarkController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none),
                ),
              ),
              customSizedBox(height: 18.h),





              Text("Town / City", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
              customSizedBox(height: 5.h),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: cityController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none),
                ),
              ),

              customSizedBox(height: 12.h),
              Text("Postcode", style: customTextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
              customSizedBox(height: 5.h),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: Colors.black54.withOpacity(0.2), width: 0.5)),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: pinCodeController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none),
                ),
              ),
              /*TextField(
                controller: postalController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
                ),
              ),*/

              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {

                    if(addressController.text.isEmpty || areaController.text.isEmpty || pinCodeController.text.isEmpty || cityController.text.isEmpty){


                       isLoading = await CustomerService.addCustomerAddress(
                          addressType: "Home",
                          address: addressController.text,
                          area: areaController.text,
                          landmark: landmarkController.text,
                          pincode: pinCodeController.text,
                          city: cityController.text,
                          state: "Maharashtra");



                       if(isLoading){
                         showCustomToast(msg: "address updated!");
                         Navigator.pop(
                             context,
                             initialAddress.copyWith(
                                 city: cityController.text,
                                 address: addressController.text,
                                 state: "Maharashtra",
                                 addressType: 'Home',
                                 area: areaController.text,
                                 landmark: landmarkController.text,
                                 pinCode: pinCodeController.text));
                       }else{
                         showCustomToast(msg: 'failed to update address');
                       }

                    }


                  },
                  child: const Text("Save Changes",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
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
                  Text("Contact Information", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Text(contactInfo.phone, style: TextStyle(fontWeight: FontWeight.normal)),
                  SizedBox(height: 4.h),
                  Text(contactInfo.email, style: TextStyle(fontSize: 13.sp)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.pink),
              onPressed: () {
                // Simulate edit
                onEdit(contactInfo.copyWith(phone: "+91-99999-00000"));
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


