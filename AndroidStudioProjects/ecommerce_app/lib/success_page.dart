import 'package:ecommerce_app/Home.dart';
import 'package:ecommerce_app/ui/route/route.dart';
import 'package:ecommerce_app/widget/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/images/success.png')),
            SizedBox(height: 25),
            Text(
              "Congratulation!!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 20),

            Text(
              "Payment is the transfer of money services in exchanges product or Payments",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            SizedBox(height: 45),
            customButton('Back to Home', ()=>Get.toNamed(home)),
          ],
        ),
      ),
    );
  }
}
