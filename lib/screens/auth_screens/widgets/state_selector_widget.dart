import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helper/constants.dart';
import '../../../helper/indian_states_list.dart';

class StateSelector extends StatelessWidget {
  final String? selectedState;
  final ValueChanged<String?> onChanged;

  const StateSelector({super.key, required this.selectedState, required this.onChanged});



  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedState,
      items: indianStates.map((state) => DropdownMenuItem(value: state, child: Text(state))).toList(),
      onChanged: onChanged,
      dropdownColor: Colors.white,
      style: customTextStyle(color: Colors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.6), width: 0.8),
        ),
        /*focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.pink, width: 1.2),
        ),*/
      ),
    );
  }
}