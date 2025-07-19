import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/screens/cart_screen/cart_screen.dart';
import 'package:twocliq/screens/home_screen/home_screen.dart';
import 'package:twocliq/screens/profile_screen/profile_screen.dart';
import '../helper/constants.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int screenIndex = 0;

  final List<Widget> listOfScreens = const [
    HomeScreen(),
    Center(child: Text("Explore Screen")),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: listOfScreens[screenIndex]),
      extendBody: true, // so navbar floats over body background
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.r),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 10,
              offset: Offset(7, 7),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: screenIndex,
          onTap: (index) {
            HapticFeedback.vibrate();
            setState(() {
              screenIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.black.withOpacity(0.4),
          selectedLabelStyle: TextStyle(fontSize: 15.sp),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.grid),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.shoppingCart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.user),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
