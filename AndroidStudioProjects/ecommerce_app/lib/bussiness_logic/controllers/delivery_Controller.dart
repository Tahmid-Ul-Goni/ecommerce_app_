import 'package:get/get.dart';

class DeliveryController extends GetxController{
  var selectedAddress='Home'.obs;

  void SelectedAddress(String address){
    selectedAddress.value=address;
  }
}