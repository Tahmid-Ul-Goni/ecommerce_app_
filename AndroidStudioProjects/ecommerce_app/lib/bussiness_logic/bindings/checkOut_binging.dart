import 'package:get/get.dart';

import '../controllers/checkOut_Controller.dart';

class CheckoutBinding implements Bindings{
  void dependencies() {
    Get.put(CheckoutController());
  }
}