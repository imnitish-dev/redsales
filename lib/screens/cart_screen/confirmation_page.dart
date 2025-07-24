import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  bool animation = false;
  bool first = false;

  final ConfettiController _controllerCenter = ConfettiController(duration: const Duration(seconds: 10));

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  startAnimation() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        first = true;
        animation = true;
      });
      _controllerCenter.play();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        setState(() {
          animation = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                particleDrag: 0.1,
                //minimumSize: Size(30,10),
                //numberOfParticles: 33,
                colors: const [
                  Colors.grey,
                  Colors.pink,
                ], // manually specify the colors to be used
              ),
            ),
            AnimatedContainer(
                height: animation ? 200 : 120,
                width: animation ? 200 : 120,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: first ? Colors.pink : const Color(0xFFF5EDE4),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.pink, blurRadius: animation ? 100 : 0, spreadRadius: 16)],
                  border: Border.all(color: Colors.white, width: animation ? 30 : 0),
                ),
                padding: EdgeInsets.all(10.r),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: first
                      ? Icon(
                          Icons.done_all,
                          color: const Color(0xFFF5EDE4),
                          size: 90.r,
                        )
                      : const CircularProgressIndicator(color: Colors.black),
                )),
            Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Order Has Been Placed Successfully!!',
                              style: customTextStyle(fontWeight: FontWeight.w500, fontSize: 22.sp),
                            ),
                          ],
                        ),
                      )),
                )),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration:
                    const BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Text(
                    'Continue Shopping!',
                    style: customTextStyle(color: const Color(0xFFF5EDE4), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            /* AppButton(
              onTap: (){
                AppNavigator.pop(context);
                if (Navigator.of(context).canPop()) {
                  AppNavigator.pop(context);
                }

              },
              width: MediaQuery.of(context).size.width-30,
              height: 50.h,
              color: Colors.pink,
                child:  Text(
                    'Continue Shopping!',
                  style: customTextStyle(
                    color: const Color(0xFFF5EDE4),
                    fontWeight: FontWeight.w600
                  ),
                ),
            ),*/
            customSizedBox(height: 10.h)
          ],
        ),
      ),
    );
  }
}
