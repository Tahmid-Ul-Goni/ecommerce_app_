
import 'package:ecommerce_app/const/app_strings.dart';
import 'package:ecommerce_app/ui/route/route.dart';
import 'package:ecommerce_app/ui/theme/add_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializedFirebase();
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

Future<void> initializedFirebase() async{
  try{
  await Firebase.initializeApp();
  Stripe.publishableKey= 'pk_test_51QuDJ3CDEy0pNUqyKBNBF7VcS4vv34w6BlKUcfaLLaluCtm9RCyxn2OcrYb2QTFvm0X4y4FmoSH6a8Gn1E0TolX600DDotclIH';
  await Stripe.instance.applySettings();
  Fluttertoast.showToast(msg: "Firebase Initialized Successfully",
  gravity:ToastGravity.BOTTOM,
  backgroundColor: Colors.green,
    toastLength:Toast.LENGTH_LONG
  );

} catch (e){ Fluttertoast.showToast(msg: "Initialized Failed");}}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,child) { return GetMaterialApp
        (title: AppString.appName,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,
      theme: AppTheme().lightTheme(context),
      darkTheme: AppTheme().darkTheme(context),
      themeMode: ThemeMode.light,
      getPages: getPages,
      initialRoute: splash,
      unknownRoute: getPages.first,

      );}
    );
  }
}


