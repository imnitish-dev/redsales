import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/referral_codes_screen.dart';

import '../../../helper/animatedPage.dart';

// Data Model
class Transaction {
  final double amount;
  final String description;
  final String date;
  final bool isCredit; // true = received, false = paid

  Transaction({
    required this.amount,
    required this.description,
    required this.date,
    required this.isCredit,
  });
}



class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  final double availableBalance = 699.02;
  final TextEditingController _referralController = TextEditingController();

  final List<Transaction> transactions = [
    Transaction(
      amount: 699.02,
      description: "Received from Mr. Rounak Shah",
      date: "6 June 2019",
      isCredit: true,
    ),
    Transaction(
      amount: 699.02,
      description: "Received from Mrs. Anamika Chaudhary",
      date: "6 June 2019",
      isCredit: true,
    ),
    Transaction(
      amount: 699.02,
      description: "Paid to Mr. Rounak Shah",
      date: "6 June 2019",
      isCredit: false,
    ),
    Transaction(
      amount: 699.02,
      description: "Received from Mrs. Tejashwi",
      date: "6 June 2019",
      isCredit: true,
    ),
    Transaction(
      amount: 699.02,
      description: "Paid to Mr. Rounak Shah",
      date: "6 June 2019",
      isCredit: false,
    ),
    Transaction(
      amount: 699.02,
      description: "Gift 🦁 from Lea B",
      date: "6 June 2019",
      isCredit: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(FeatherIcons.chevronLeft,size: 25.r)),
                      customSizedBox(width: 5.w),
                      Text("Wallet", style: customTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(openAnimatedPage(
                            ReferralCodesScreen()
                        ));
                      },
                      child: Text("Referral Codes", style: TextStyle(color: Colors.pink, fontSize: 14.sp))),
                ],
              ),
              SizedBox(height: 20.h),

              /// Balance Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "₹${availableBalance.toStringAsFixed(2)}",
                      style: customTextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold),
                    ),
                    Text("Available Balance", style: customTextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15.sp,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              /// Referral Code Field
              referralInputWidget(),
              SizedBox(height: 20.h),

              /// Payment History Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.r),
                    child: Text("Payment History", style: customTextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                  ),
                  Row(
                    children: [
                      Text("View all", style: customTextStyle(color: Colors.pink, fontSize: 14.sp)),
                      Icon(Icons.arrow_forward_ios, color: Colors.pink, size: 16.r),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              /// Transaction List
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.all(8.r),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final tx = transactions[index];
                      return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Left Info
                              Expanded(
                                // <-- Added to prevent overflow
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "₹${tx.amount.toStringAsFixed(2)}",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      tx.description,
                                      style: customTextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                      maxLines: 1, // Limit to 1 line
                                      overflow: TextOverflow.ellipsis, // Add "..." if it overflows
                                    ),
                                  ],
                                ),
                              ),

                              /// Right Info
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    tx.isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                                    color: tx.isCredit ? Colors.teal : Colors.pink,
                                    size: 20,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    tx.date,
                                    style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget referralInputWidget(){
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          controller: _referralController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: "Enter Referral Code",
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.pink, width: 1),
            ),
          ),
        ),

        /// Show button if text isn't empty
        if (_referralController.text.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                minimumSize: Size(60, 35),
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                // Handle button click (like apply referral code)
                debugPrint("Referral Code: ${_referralController.text}");
              },
              child: const Text("Apply", style: TextStyle(color: Colors.white)),
            ),
          ),
      ],
    );
  }
}

