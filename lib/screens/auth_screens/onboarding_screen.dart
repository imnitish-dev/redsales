import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/screens/auth_screens/sign_in_screen.dart';

/*
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Top Image
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      "assets/onboarding/one.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),

              /// Page Indicator + Navigation
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const SignInScreen()),
                              (route) => false,
                        );
                      },
                      child: Text(
                        "SKIP",
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                      ),
                    ),
                    const PageIndicator(
                      currentIndex: 1,   // current page index (0-based)
                      itemCount: 3,      // total pages
                      activeColor: Colors.red,
                      inactiveColor: Colors.grey,
                    ),
                    TextButton(
                      onPressed: (){

                      },
                      child: Text(
                        "NEXT",
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              /// Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: Text(
                  "title",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              /// Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
                child: Text(
                  "description",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        )
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  final Color activeColor;
  final Color inactiveColor;
  final double activeDotWidth;
  final double dotHeight;
  final double inactiveDotWidth;
  final double spacing;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.grey,
    this.activeDotWidth = 12,
    this.inactiveDotWidth = 8,
    this.dotHeight = 8,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: spacing.w),
          width: (isActive ? activeDotWidth : inactiveDotWidth).w,
          height: dotHeight.h,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}*/

class OnboardingItem {
  final String imagePath;
  final String title;
  final String description;

  OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // List of onboarding data
  final List<OnboardingItem> _pages = [
    OnboardingItem(
      imagePath: "assets/onboarding/one.png",
      title: "Discover New Products",
      description:
      "Explore a variety of products curated just for you with great deals and offers.",
    ),
    OnboardingItem(
      imagePath: "assets/onboarding/two.png",
      title: "Track Your Orders",
      description:
      "Easily track your orders and get real-time updates delivered to your device.",
    ),
    OnboardingItem(
      imagePath: "assets/onboarding/three.png",
      title: "Fast and Secure Checkout",
      description:
      "Enjoy fast, easy, and secure checkout with multiple payment options.",
    ),
  ];

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      // Last page - Navigate to SignIn
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SignInScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = _pages[_currentPage];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Top Image
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    currentItem.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            /// Page Indicator + Navigation
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const SignInScreen()),
                            (route) => false,
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                    ),
                  ),
                  PageIndicator(
                    currentIndex: _currentPage,
                    itemCount: _pages.length,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey,
                  ),
                  TextButton(
                    onPressed: _goToNextPage,
                    child: Text(
                      _currentPage == _pages.length - 1 ? "Login" : "Next",
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            /// Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Text(
                currentItem.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            /// Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
              child: Text(
                currentItem.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

/// Reusable Page Indicator Widget
class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  final Color activeColor;
  final Color inactiveColor;
  final double activeDotWidth;
  final double dotHeight;
  final double inactiveDotWidth;
  final double spacing;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.grey,
    this.activeDotWidth = 12,
    this.inactiveDotWidth = 8,
    this.dotHeight = 8,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: spacing.w),
          width: (isActive ? activeDotWidth : inactiveDotWidth).w,
          height: dotHeight.h,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}