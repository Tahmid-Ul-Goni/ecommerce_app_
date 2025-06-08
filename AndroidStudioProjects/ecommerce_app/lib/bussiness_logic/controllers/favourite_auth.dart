import 'package:ecommerce_app/model/user_favourite.dart';
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController{
  RxList<Favourite> items = RxList<Favourite>([]);

  fetch() async {
    try {
      print("Fetching favourite items...");
      var favItems = await FirestoreDB().getFavouriteItems();
      print("Fetched ${favItems.length} items");
      favItems.forEach((item) {
        print("Item title: ${item.title}, Price: ${item.price}");
      });
      items.value = favItems;
    } catch (e) {
      print("Error fetching favourite items: $e");
    }
  }}