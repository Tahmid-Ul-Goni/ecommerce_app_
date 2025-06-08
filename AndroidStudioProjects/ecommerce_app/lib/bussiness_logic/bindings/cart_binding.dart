import 'package:ecommerce_app/bussiness_logic/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartBinding implements Bindings{
  void dependencies() {
    Get.put(CartController());
  }
}