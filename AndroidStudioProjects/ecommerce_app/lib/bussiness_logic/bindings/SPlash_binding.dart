import 'package:ecommerce_app/bussiness_logic/controllers/Splash_auth.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}