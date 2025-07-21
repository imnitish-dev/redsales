import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/provider/cart_provider.dart';
import 'package:twocliq/provider/customer_profile_provider.dart';
import 'package:twocliq/provider/detailed_product_screen_provider.dart';
import 'package:twocliq/provider/home_provider.dart';
import 'package:twocliq/provider/orders_provider.dart';
import 'package:twocliq/screens/splash_screen.dart';
import 'package:twocliq/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => DetailedProductScreenProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProfileProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.72727272727275, 850.9090909090909),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TwoCliq',
            theme: AppTheme.lightTheme(context),
            home: child,
          );
        },
        child: const SplashScreen()
        // child: const PdfSaveScreen(),
        );
  }
}
