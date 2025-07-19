import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/my_profile_screen.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/order_history_screen.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/change_password_screen.dart';
import 'package:twocliq/screens/profile_screen/other_profile_screens/wallet_screen.dart';
import 'package:twocliq/screens/wishlist_screen.dart';

import '../../helper/animatedPage.dart';
import '../product_detail_screen/write_review_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            customSizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ReusableCard(
                      title: "My Profile",
                      imagePath: "assets/icons/profile_icons/my_profile_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        Navigator.of(context).push(openAnimatedPage(
                            MyProfileScreen()
                        ));
                      },
                    ),
                    ReusableCard(
                      title: "Wishlist",
                      imagePath: "assets/icons/profile_icons/wishlist_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        Navigator.of(context).push(openAnimatedPage(
                            WishlistScreen()
                        ));
                      },
                    ),
                    ReusableCard(
                      title: "Order History",
                      imagePath: "assets/icons/profile_icons/order_history_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        Navigator.of(context).push(openAnimatedPage(
                            OrderHistoryScreen()
                        ));
                      },
                    ),
                    ReusableCard(
                      title: "Wallet",
                      imagePath: "assets/icons/profile_icons/wallet_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        Navigator.of(context).push(openAnimatedPage(
                            WalletScreen()
                        ));
                      },
                    ),
                    ReusableCard(
                      title: "Referral Codes",
                      imagePath: "assets/icons/profile_icons/referral_code_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        print("Profile card clicked!");
                      },
                    ),
                    ReusableCard(
                      title: "Transaction History",
                      imagePath: "assets/icons/profile_icons/transaction_history_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        print("Profile card clicked!");
                      },
                    ),
                    ReusableCard(
                      title: "Payment Method",
                      imagePath: "assets/icons/profile_icons/payment_method_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        print("Profile card clicked!");
                      },
                    ),
                    ReusableCard(
                      title: "Address",
                      imagePath: "assets/icons/profile_icons/address_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        print("Profile card clicked!");
                      },
                    ),
                    ReusableCard(
                      title: "Password",
                      imagePath: "assets/icons/profile_icons/password_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        Navigator.of(context).push(openAnimatedPage(
                            ChangePasswordScreen()
                        ));
                      },
                    ),
                    ReusableCard(
                      title: "Help",
                      imagePath: "assets/icons/profile_icons/help_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        print("Profile card clicked!");
                      },
                    ),
                    ReusableCard(
                      title: "Privacy Policy",
                      imagePath: "assets/icons/profile_icons/privacy_policy_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        print("Profile card clicked!");
                      },
                    ),
                    ReusableCard(
                      title: "Terms & Conditions",
                      imagePath: "assets/icons/profile_icons/terms&cond_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        print("Profile card clicked!");
                      },
                    ),
                    ReusableCard(
                      title: "Legal",
                      imagePath: "assets/icons/profile_icons/legal_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        print("Profile card clicked!");
                      },
                    ),
                    ReusableCard(
                      title: "Delete Account",
                      imagePath: "assets/icons/profile_icons/delete_ac_icon.png",
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {
                        print("Profile card clicked!");
                      },
                    ),
                    Padding(
                      padding:  EdgeInsets.all(12.r),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => DeleteAccountOverlay(
                                onCancel: (){
                                  Navigator.pop(context);
                                },
                                onDelete: (){
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final IconData trailingIcon;
  final VoidCallback onTap;

  const ReusableCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.trailingIcon = Icons.arrow_forward_ios, // default
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3), // soft shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
           /* CircleAvatar(
              radius: 24.r,
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Colors.grey.shade100,
            ),*/
            Image.asset(imagePath,width: 40.r,height: 40.r),
            customSizedBox(width: 12.w),

            // Title
            Expanded(
              child: Text(
                title,
                style: customTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Trailing Icon
            Icon(trailingIcon, size: 18.sp, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}

class DeleteAccountOverlay extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  const DeleteAccountOverlay({
    super.key,
    required this.onCancel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7), // Dimmed overlay background
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// White Card
            Container(
              width: 300.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50.h), // Space for circle icon

                  /// Main Title
                  Text(
                    "You are going to delete\nyour account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Subtext
                  Text(
                    "You won't be able to restore your data",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  /// Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onCancel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: const Text("Cancel",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onDelete,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: const Text("Delete",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Top Circle Icon (User with Minus)
            Positioned(
              top: -60.r,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 120.r,
                  height: 120.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink.shade50,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 60.r,
                      height: 60.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                      child: const Icon(
                        Icons.person_remove, // Delete-like icon
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}