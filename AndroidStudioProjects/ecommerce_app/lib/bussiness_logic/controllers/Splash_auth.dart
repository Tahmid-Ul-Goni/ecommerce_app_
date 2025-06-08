import 'dart:async';
import 'package:ecommerce_app/ui/route/route.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  chooseScreen() {
    var value = box.read('user');
    if (value['uid'] == null) {
      Get.offAndToNamed(intro);
    } else {
     Get.offAndToNamed(login);
    }
  }

  @override
  void onInit() {
    Timer(Duration(seconds: 3), () => chooseScreen());
    super.onInit();
  }
}
