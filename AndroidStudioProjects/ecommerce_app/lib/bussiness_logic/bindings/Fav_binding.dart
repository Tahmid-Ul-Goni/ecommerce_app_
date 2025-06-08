
import 'package:get/get.dart';

import '../controllers/favourite_auth.dart';

class FavouriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> FavouriteController());
  }
}