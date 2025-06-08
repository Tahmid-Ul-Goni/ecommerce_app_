import 'package:ecommerce_app/bussiness_logic/controllers/favourite_auth.dart';
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final FavouriteController _favouriteController =
  Get.find<FavouriteController>();

  @override
  void initState() {
    super.initState();
    _favouriteController.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(20),
      child: Obx(
            () {
          final items = _favouriteController.items;

          if (items.isEmpty) {
            return Center(child: Text("No favourites yet"));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];
              return Stack(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: item.thumbnail != null
                          ? Image.network(item.thumbnail!, width: 50, height: 50)
                          : Icon(Icons.image_not_supported),
                      title: Text(item.title ?? "No Title"),
                      subtitle: Text("Price: \$${item.price ?? 0}"),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: IconButton(
                      onPressed: () {
                        FirestoreDB().deleteitems(items[index].docId);
                        _favouriteController.fetch();
                      },
                      icon: Icon(Icons.remove_circle_outline_rounded, color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}