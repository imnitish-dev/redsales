import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twocliq/helper/constants.dart';

import '../../../models/product_detail_model.dart';

class SpecificationsWidget extends StatefulWidget {
  final List<DetailProductSpecification>? productSpecification;
  const SpecificationsWidget({super.key, required this.productSpecification});

  @override
  State<SpecificationsWidget> createState() => _SpecificationsWidgetState();
}

class _SpecificationsWidgetState extends State<SpecificationsWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.productSpecification == null
        ? customSizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 20.w),
                child: Text("Specifications", style: customTextStyle(fontSize: 20.sp)),
              ),
              customSizedBox(height: 5.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: widget.productSpecification?.length,
                itemBuilder: (context, index) {
                  final currentSpecification = widget.productSpecification?[index];
                  return currentSpecification?.key != null && currentSpecification?.value != null
                      ? Padding(
                          padding: EdgeInsets.all(5.r),
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "${currentSpecification?.key ?? ""} : ",
                                    style: customTextStyle(
                                        fontSize: 17.sp, fontWeight: FontWeight.normal, color: Colors.black)),
                                TextSpan(
                                    text: currentSpecification?.value ?? "",
                                    style: customTextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black.withOpacity(0.5)))
                              ],
                            ),
                          ),
                        )
                      : customSizedBox();
                },
              ),
            ],
          );
  }
}
