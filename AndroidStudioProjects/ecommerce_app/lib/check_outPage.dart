import 'package:ecommerce_app/bussiness_logic/controllers/cart_controller.dart';
import 'package:ecommerce_app/bussiness_logic/controllers/delivery_Controller.dart';
import 'package:ecommerce_app/const/app_color.dart';
import 'package:ecommerce_app/widget/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'bussiness_logic/controllers/checkOut_Controller.dart';

class CheckoutPage extends StatelessWidget {
  final checkoutController = Get.find<CheckoutController>();
  final CartController cartController = Get.find<CartController>();
  final deliveryController = Get.put(DeliveryController());

  @override
  Widget build(BuildContext context) {
    int subTotal = cartController.getTotal;
    int deliveryFee = 50;
    int totalAmount = subTotal + deliveryFee;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            deliveryAddress("Home", "(342) 4522019", "220 Kuala Lampur"),
            SizedBox(height: 15),
            deliveryAddress("office", "(342) 4522019", "350 Selangor"),
            SizedBox(height: 40),
            Text(
              "Billing Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            billingInfo('Delivery fee', 50),
            billingInfo('SubTotal', cartController.getTotal),
            billingInfo('Total', totalAmount, isTotal: true),
            SizedBox(height: 30),
            Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Image.asset('assets/images/Stripe.png', width: 150, height: 150),
          ],
        ),
      ),
      bottomSheet: customButton('Tap to Payment', () {
        checkoutController.checkOut(
          currency: 'USD',
          amount: totalAmount.toString(),
        );
      }),
    );
  }
}

Widget deliveryAddress(String title, String phone, String address) {
  final deliveryController = Get.find<DeliveryController>();
  return Obx(() {
    bool isSelected = deliveryController.selectedAddress.value == title;

    return GestureDetector(
      onTap: () {
        deliveryController.SelectedAddress(title);
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 3,
            color: isSelected ? AppColors.mandarinColor : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(phone),
            Text(address),
          ],
        ),
      ),
    );
  });
}

Widget billingInfo(String title, int amount, {bool isTotal = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
        ),
        SizedBox(width: 50),
        Text("\$$amount"),
      ],
    ),
  );
}
