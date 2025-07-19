import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

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
  }

  AddressInfo addressInfo = AddressInfo(
    title: "Shipping Address",
    details: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
  );

  ContactInfo contactInfo = ContactInfo(
    phone: "+91- 97704-09874",
    email: "amandegar213@gmail.com",
  );

  List<CartItem> cartItems = [
    CartItem(
      imageUrl: "https://picsum.photos/200/305",
      description: "Lorem ipsum dolor sit amet consectetur.",
      price: "₹699",
      quantity: 1,
    ),
    CartItem(
      imageUrl: "https://picsum.photos/200/306",
      description: "Lorem ipsum dolor sit amet consectetur.",
      price: "₹699",
      quantity: 1,
    ),
  ];

  Voucher? selectedVoucher;
  String selectedPaymentMethod = "Card";

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

  void updateCartItems(List<CartItem> updatedCart) {
    setState(() {
      cartItems = updatedCart;
    });
  }

  void applyVoucher(Voucher voucher) {
    setState(() {
      selectedVoucher = voucher;
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
            Text(
              "Payment",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    AddressWidget(
                      addressInfo: addressInfo,
                      onEdit: updateAddress,
                    ),
                    SizedBox(height: 12.h),
                    ContactWidget(
                      contactInfo: contactInfo,
                      onEdit: updateContact,
                    ),
                    SizedBox(height: 20.h),
                    CartItemsSection(
                      cartItems: cartItems,
                      onCartChanged: updateCartItems,
                    ),
                    SizedBox(height: 20.h),
                    VoucherWidget(
                      selectedVoucher: selectedVoucher,
                      onApply: applyVoucher,
                    ),
                    SizedBox(height: 20.h),
                    PaymentMethodWidget(
                      selectedMethod: selectedPaymentMethod,
                      onChange: changePaymentMethod,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            CheckoutFooter(total: "₹12,00"),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String imageUrl;
  final String description;
  final String price;
  final int quantity;

  CartItem({
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({String? imageUrl, String? description, String? price, int? quantity}) {
    return CartItem(
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartItemsSection extends StatefulWidget {
  final List<CartItem> cartItems;
  final ValueChanged<List<CartItem>> onCartChanged;

  const CartItemsSection({
    super.key,
    required this.cartItems,
    required this.onCartChanged,
  });

  @override
  State<CartItemsSection> createState() => _CartItemsSectionState();
}

class _CartItemsSectionState extends State<CartItemsSection> {
  late List<CartItem> localCart;

  @override
  void initState() {
    super.initState();
    localCart = List.from(widget.cartItems);
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      localCart[index] = localCart[index].copyWith(
        quantity: (localCart[index].quantity + delta).clamp(1, 99),
      );
      widget.onCartChanged(localCart);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      "${localCart.length}",
                      style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
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
            itemCount: localCart.length,
            itemBuilder: (context, index) {
              final item = localCart[index];
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
                              backgroundImage: NetworkImage(item.imageUrl),
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
                                "${item.quantity}",
                                style: TextStyle(
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
                        item.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black.withOpacity(0.8)),
                      ),
                    ),

                    /// Price
                    Text(
                      item.price,
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
  final String title;
  final String details;

  AddressInfo({required this.title, required this.details});

  AddressInfo copyWith({String? title, String? details}) {
    return AddressInfo(
      title: title ?? this.title,
      details: details ?? this.details,
    );
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
                  Text(addressInfo.title,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Text(addressInfo.details, style: TextStyle(fontSize: 13.sp)),
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
  Future<AddressInfo?> _showEditAddressModal(
      BuildContext context, AddressInfo initialAddress) async {
    final addressController = TextEditingController(text: initialAddress.details);
    final cityController = TextEditingController(text: "Bengaluru, Karnataka");
    final postalController = TextEditingController(text: "560023");

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
                  Text("Shipping Address",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
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
               Text("Country",
                  style: customTextStyle(fontWeight: FontWeight.w600,fontSize: 16.sp)
               ),
              customSizedBox(height: 4.h),
               Text("India",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),

              customSizedBox(height: 12.h),
               Text("Address",
                  style: customTextStyle(fontWeight: FontWeight.w600,fontSize: 16.sp)
              ),
              customSizedBox(height: 5.h),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: Colors.black54.withOpacity(0.2),
                    width: 0.5
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none
                  ),
                ),
              ),
              customSizedBox(height: 18.h),

               Text("Town / City",
                  style: customTextStyle(fontWeight: FontWeight.w600,fontSize: 16.sp)
               ),
              customSizedBox(height: 5.h),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                        color: Colors.black54.withOpacity(0.2),
                        width: 0.5
                    )
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: cityController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none
                  ),
                ),
              ),



              customSizedBox(height: 12.h),
              Text("Postcode",
                  style: customTextStyle(fontWeight: FontWeight.w600,fontSize: 16.sp)
              ),
              customSizedBox(height: 5.h),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                        color: Colors.black54.withOpacity(0.2),
                        width: 0.5
                    )
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: postalController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none
                  ),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(
                        context,
                        initialAddress.copyWith(
                          details: addressController.text,
                        ));
                  },
                  child: const Text("Save Changes",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
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

class VoucherWidget extends StatelessWidget {
  final Voucher? selectedVoucher;
  final ValueChanged<Voucher> onApply;

  const VoucherWidget({
    super.key,
    required this.selectedVoucher,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final sampleVoucher = Voucher(
      code: "SAVE200",
      description: "Save 200 on this order",
      discount: 200,
    );

    return Padding(
      padding:  EdgeInsets.only(left: 20.w,right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Voucher",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          customSizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.card_giftcard, color: Colors.pink),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sampleVoucher.description,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "View all Vouchers >",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => onApply(sampleVoucher),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(80, 40), // Fix size to avoid constraint issues
                  ),
                  child: const Text("Apply", style: TextStyle(color: Colors.pink)),
                ),
              ],
            ),
          ),
        ],
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
    final methods = ["Card", "UPI", "Net Banking"];

    return Padding(
      padding:  EdgeInsets.only(left: 20.w,right: 20.w),
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
                    onTap: () => onChange(method),
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

class CheckoutFooter extends StatelessWidget {
  final String total;
  const CheckoutFooter({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Total ",
                      style: customTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: total, // your total string like "₹12,00"
                      style: customTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showPaymentSummary(context);
                  //print("Payment Summary clicked");
                },
                child: RichText(
                  text: TextSpan(
                    text: "Payment Summary",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      color: Colors.yellow.shade800,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )


            ],
          ),
          SizedBox(
            height: 60.h,
            width: 200.w,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Colors.pink,
              ),
              child: Text("Pay", style: customTextStyle(color: Colors.white,fontSize: 20.sp)),
            ),
          ),
        ],
      ),
    );
  }

  void showPaymentSummary(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Wrap( // Wrap allows the modal to size itself to content
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Summary",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.black54),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                DottedLine(
                  dashColor: Colors.grey.withOpacity(0.4),
                  dashLength: 5,
                  dashGapLength: 3,
                  lineThickness: 2,
                ),
                SizedBox(height: 12),
                _buildSummaryRow("Item Total", "₹699"),
                _buildSummaryRow("Discount Tax", "₹02.00"),
                _buildSummaryRow("Delivery Free| 4.7 kms", "₹26.00"),
                _buildSummaryRow("Wallet Deduction", "₹00.00"),
                _buildSummaryRow("Delivery Tip", "Add Tip", isLink: true),
                DottedLine(
                  dashColor: Colors.grey.withOpacity(0.4),
                  dashLength: 5,
                  dashGapLength: 3,
                  lineThickness: 2,
                ),
                SizedBox(height: 8),
                _buildSummaryRow("To Pay", "₹699", isBold: true),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String title, String value,
      {bool isBold = false, bool isLink = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isLink ? Colors.pink : Colors.grey.shade700,
              decoration:
              isLink ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isLink ? Colors.pink : Colors.black,
              decoration:
              isLink ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }



}
