
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twocliq/helper/constants.dart';

import '../../helper/animatedPage.dart';
import '../search_screen.dart';

class HomeHeaderWidget extends StatelessWidget {
  final int notificationCount;
  final int cartCount;
  const HomeHeaderWidget(
      {super.key, required this.notificationCount, required this.cartCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // IconButton(
                //   icon: const Icon(Icons.menu),
                //   onPressed: () {
                //     // Handle menu button press
                //     Scaffold.of(context).openDrawer();
                //   },
                // ),
                // const SizedBox(width: 0),
                Image.asset(
                  'assets/images/logo_horizontal.png',
                  height: 30,
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.all(12.0.r ),
              child: Row(
                children: [

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(openAnimatedPage(
                          SearchWithFilterScreen()
                      ));
                    },
                    child: SvgPicture.asset(
                      "assets/svg/search.svg",
                      width: 24.r,  // optional
                      height: 24.r, // optional
                    ),
                  ),

                  customSizedBox(width: 15.w),

                  SvgPicture.asset(
                    "assets/svg/notification.svg",
                    width: 24.r,  // optional
                    height: 24.r, // optional
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithBadge({
    required IconData icon,
    required int count,
    required VoidCallback onPressed,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
        if (count > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
