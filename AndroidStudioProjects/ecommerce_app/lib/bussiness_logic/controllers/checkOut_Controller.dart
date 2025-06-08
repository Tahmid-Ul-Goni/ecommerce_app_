import 'dart:convert';
import 'package:ecommerce_app/ui/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CheckoutController extends GetxController {
  Map<String, dynamic>? checkoutData;

  Future<void> checkOut({
    required String currency,
    required String amount,
  }) async {
    try {
      checkoutData = await createCheckout(amount, currency);

      if (checkoutData != null && checkoutData!['client_secret'] != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            merchantDisplayName: 'Tajwar',
            style: ThemeMode.dark,
            paymentIntentClientSecret: checkoutData!['client_secret'],
          ),
        );

        await presentPaymentSheet();
      } else {
        Get.snackbar('Error', 'Invalid Checkout Data');
      }
    } catch (e) {
      print('Exception during checkout: $e');
      Get.snackbar('Checkout Failed', 'Something went wrong');
    }
  }
}

Future<void> presentPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet();
    print('Payment Successful');
    Get.toNamed(successPage);
  } on StripeException catch (e) {
    print('StripeException: ${e.error.localizedMessage}');
    Get.snackbar('Checkout Failed', '${e.error.localizedMessage}');
  } catch (e) {
    print('Unknown error: $e');
    Get.snackbar('Checkout Failed', 'An unexpected error occurred');
  }
}

Future<Map<String, dynamic>?> createCheckout(
    String amount,
    String currency,
    ) async {
  try {
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card',
    };

    var response = await https.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      body: body,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'content-type': 'application/x-www-form-urlencoded'
      },
    );

    print('Stripe API Response: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Stripe Error: ${response.statusCode}');
    }
  } catch (err) {
    print('Error during createCheckout: $err');
  }
  return null;
}

String calculateAmount(String amount) {
  final a = (int.parse(amount)) * 100;
  return a.toString();
}