
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:get/get.dart';
import '../../model/User_cart.dart';

class CartController extends GetxController {
  RxList<UserCart> items = RxList<UserCart>([]);

  fetch() async {
    var Cartitems = await FirestoreDB().GetCart();
    items.value = Cartitems;
  }

  @override
  void onInit() {
    fetch();
    super.onInit();
  }
  int get getTotal =>
      items.fold(0, (previousValue, element) => previousValue + (element.price ?? 0));
}


