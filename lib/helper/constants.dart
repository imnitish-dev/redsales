import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:twocliq/main.dart';


//#F71140
const kPrimaryColor = Color(0xFFF71140); // Red
const kPrimaryLightColor = Color(0xFFFFCDD2); // Light Red
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFE57373),
    Color.fromARGB(255, 211, 47, 47)
  ], // Gradient from light red to red
);
const kSecondaryColor = Color(0xFFBDBDBD); // Grey
const kTextColor = Colors.black;
const kBorderColor = Color.fromARGB(90, 120, 120, 120);

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

// final otpInputDecoration = InputDecoration(
//   contentPadding: const EdgeInsets.symmetric(vertical: 16),
//   border: outlineInputBorder(),
//   focusedBorder: outlineInputBorder(),
//   enabledBorder: outlineInputBorder(),
// );

// OutlineInputBorder outlineInputBorder() {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.circular(16),
//     borderSide: const BorderSide(color: kTextColor),
//   );
// }

TextStyle customTextStyle({
  Color? color = Colors.black,
  double? fontSize = 16,
  FontWeight? fontWeight = FontWeight.normal,
  //String? fontName = ""
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
     fontFamily: "Poppins"
  );
}

Widget customSizedBox({
  double? width,
  double? height,
}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}

class AppColors {
  // static const Color primary = Color(0xFFFFC700);
  // static const Color background = Color(0xFFFFFFFF);
  // static const Color cardBackground = Color(0xFFF2F2F7);
  // static const Color text = Color(0xFF000000);
  // static const Color secondaryText = Color(0xFF8E8E93);
  // static const Color success = Color(0xFF34C759);
  // static const Color error = Color(0xFFFF3B30);
  static const BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 255, 255, 255), //0xFFFFC700
      ],
      stops: [0.0503, 0.9325],
      transform: GradientRotation(
          188.67 * 3.1415926535897932 / 180), // Convert degrees to radians
    ),
  );
}

// Create a Logger instance
final Logger logger = Logger();

// 1. Normal log function
void logInfo(dynamic message) {
  logger.i(message.toString()); // 'i' for Info log level
}

// 2. Error log function
void logError(dynamic errorMessage) {
  logger.e(errorMessage.toString()); // 'e' for Error log level
}

Future<bool> checkNetConnectivity() async {
  bool isConnected = await InternetConnectionChecker().hasConnection;
  if (isConnected) {

  } else {
    if (kDebugMode) {
      logError('No internet!!');
    }
  }
  return isConnected;
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final bool canBeEmpty;
  final String label;
  final String? hint;
  final TextStyle labelTextStyle;
  final TextStyle textFieldStyle;
  final TextInputType customKeyboardType;
  final void Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final bool? readOnly;
  final int? textLimit;

  const AppTextField(
      {Key? key,
        required this.controller,
        required this.formKey,
        required this.label,
        this.hint,
        required this.canBeEmpty,
        this.labelTextStyle = const TextStyle(),
        this.textFieldStyle = const TextStyle(),
        this.onChanged,
        this.readOnly,
        this.textLimit,
        required this.customKeyboardType, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 9, left: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: labelTextStyle,
                  ),
                  Text(
                    !canBeEmpty ? ' *' : '',
                    style: customTextStyle(color: Colors.red, fontSize: 15),
                  )
                ],
              ),
            ),
            TextFormField(
              readOnly: readOnly ?? false,
              maxLines: null,
              keyboardType: customKeyboardType,
              controller: controller,
              onChanged: onChanged,
              maxLength: textLimit,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              // validator: validator,
              validator: (value) {
                if (!canBeEmpty && (value == null || value.isEmpty)) {
                  return 'Please enter $label';
                }

                if(!canBeEmpty && textLimit!=null && value?.length != textLimit ){
                  return 'Please enter $textLimit digit number';
                }

                // if (!canBeEmpty && (value?.length != textLimit || value!.isEmpty || value == null)) {
                //   return 'Please enter $textLimit digit alphanumeric code';
                // }

                if(customKeyboardType == TextInputType.emailAddress){
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value!)) {
                    return "Please enter a valid email address";
                  }
                }

                if (customKeyboardType == TextInputType.visiblePassword) {
                  if (value!.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                }

                if(customKeyboardType == TextInputType.phone){
                  if (value?.length != 10) {
                    return "Mobile number must be 10 digits";
                  }
                  if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value!)) {
                    return "Please enter a valid Indian mobile number";
                  }
                }


                if (customKeyboardType == TextInputType.text) {
                  if (value is! String || (value.isEmpty && !canBeEmpty)) {
                    return 'Please enter text';
                  }
                }

                if (!canBeEmpty) {
                  if (customKeyboardType == TextInputType.number) {
                    if (value != null) {
                      if (!isNumeric(value)) {
                        return 'Please enter a valid number';
                      }
                    }
                  }
                }

                return null;
              },
              style: customTextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: customTextStyle(
                  color: Colors.black54,
                  fontSize: 15.sp
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorStyle:
                customTextStyle(color: Colors.redAccent, fontSize: 15),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.black12, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ));
  }
}

void showCustomToast({ required
String msg ,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showErrorToast({ required
String msg ,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.redAccent,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

bool isNumeric(String? value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}

bool validateAllForms(List<GlobalKey<FormState>> formKeys) {
  bool allValid = true;

  for (var formKey in formKeys) {
    if (formKey.currentState == null) {
      continue;
    }

    if (!formKey.currentState!.validate()) {
      allValid = false;
    }
  }

  return allValid;
}