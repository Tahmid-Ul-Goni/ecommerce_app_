import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/bussiness_logic/controllers/cart_controller.dart';
import 'package:ecommerce_app/bussiness_logic/controllers/favourite_auth.dart';
import 'package:ecommerce_app/const/app_color.dart';
import 'package:ecommerce_app/model/Products.dart';
import 'package:ecommerce_app/model/User_cart.dart';
import 'package:ecommerce_app/model/user_favourite.dart';
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:ecommerce_app/ui/route/route.dart';
import 'package:ecommerce_app/widget/custom_ToastMsg.dart';
import 'package:ecommerce_app/widget/custom_buttom.dart';
import 'package:ecommerce_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          children: [customFormField(TextInputType.text, _searchController, context, 'Search here', (null),prefixIcon: Icons.search,),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () => FirestoreDB().getProducts(),
                child: FutureBuilder<List<Products>>(
                  future: FirestoreDB().getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          return InkWell(
                            onTap:
                                () => Get.toNamed(
                                  detailsScreen,
                                  arguments: snapshot.data![index],
                                ),
                            child: Ink(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: snapshot.data![index].thumbnail,
                                    height: 100,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                            Icon(Icons.error),
                                  ),
                                  Text(
                                    product.brand,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '\$${product.price.toString()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No products found'));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  Products data;
  DetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirestoreDB().checkfavourite(data.id),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              }
              return IconButton(
                onPressed: () async {
                  final favouriteData = Favourite(
                    brand: data.brand,
                    id: data.id,
                    thumbnail: data.thumbnail,
                    title: data.title,
                  );
                  if (snapshot.data!.docs.isEmpty) {
                    await FirestoreDB().addToFavourite(favouriteData);
                    Get.find<FavouriteController>().fetch();
                  } else {
                    ToastWidget('Already Added', Colors.red);
                  }
                },
                icon:
                    snapshot.data!.docs.isEmpty
                        ? Icon(Icons.favorite_outline)
                        : Icon(Icons.favorite, color: Colors.red),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 450,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    data.images
                        .map(
                          (e) => Container(
                            width: 400,
                            margin: EdgeInsets.only(right: 8),
                            child: CachedNetworkImage(
                              imageUrl: e,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),

              Container( height: 290.h, width:355.w,decoration: BoxDecoration(borderRadius:BorderRadius.circular(45),shape: BoxShape.rectangle,color: AppColors.whiteColor,),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      ),SizedBox(height: 10,),
                      Text(
                        data.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.grayColor,
                        ),
                      ),SizedBox(height: 20,),
                      Text(
                        '\$ ${data.price.toString()}',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mandarinColor,
                        ),
                      ),SizedBox(height: 10,),
                      Positioned(left: 20,right:20,bottom: 10,child:Center(
                        child: customButton('Add to cart', () async {
                          final cartData = UserCart(
                            brand: data.brand,
                            description: data.description,
                            id: data.id,
                            price: data.price,
                            thumbnail: data.thumbnail,
                            title: data.title,
                          );
                          await FirestoreDB().AddtoCart(cartData);
                          Get.find<CartController>().fetch();
                        }),
                      ),
                      ) ],
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
