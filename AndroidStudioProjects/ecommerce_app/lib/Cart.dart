import 'package:ecommerce_app/bussiness_logic/controllers/cart_controller.dart';
import 'package:ecommerce_app/bussiness_logic/controllers/checkOut_Controller.dart';
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:ecommerce_app/ui/route/route.dart';
import 'package:ecommerce_app/widget/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartController _cartController = Get.find<CartController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Obx(() {
          final items = _cartController.items;
          if (items.isEmpty) {
            return Center(child: Text('No Items Yet'));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading:
                          items[index].thumbnail != null
                              ? Image.network(
                                items[index].thumbnail!,
                                height: 50,
                                width: 50,
                              )
                              : Icon(Icons.image_not_supported_outlined),
                      title: Text(items[index].title ?? 'No tittle'),
                      subtitle: Text("price \$${items[index].price ?? 0}"),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        FirestoreDB().deleteCartItems(items[index].docId);
                        _cartController.fetch();
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12),
        child: customButton(
          'Check Out',
          () => Get.toNamed(checkoutPage)
        ),
      ),
    );
  }
}
