import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/bussiness_logic/controllers/favourite_auth.dart';
import 'package:ecommerce_app/model/Products.dart';
import 'package:ecommerce_app/model/User_cart.dart';
import 'package:ecommerce_app/model/user_profile.dart';
import 'package:ecommerce_app/widget/custom_ToastMsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/user_favourite.dart';

class FirestoreDB {
  var box = GetStorage();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserProfile> getUserProfile() async {
    if (kIsWeb) throw Exception("User profile not supported on Web");
    final snapshot =
        await _firebaseFirestore
            .collection('users')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .get();
    return snapshot.docs.map((e) => UserProfile.fromSnapshot(e)).single;
  }

  Future<void> userProfileUpdate(UserProfile user) async {
    if (kIsWeb) return;
    await _firebaseFirestore
        .collection('users')
        .doc(user.email)
        .update(user.toJson())
        .then((value) => ToastWidget('Update Data Successfully', Colors.green));
  }

  Future<List<Products>> getProducts() async {
    if (kIsWeb) {
      // demo for web
    }

    final snapshot = await _firebaseFirestore.collection('products').get();
    return snapshot.docs.map((e) => Products.fromSnapshot(e)).toList();
  }

  Future<void> addToFavourite(Favourite favourite) async {
    if (kIsWeb) return;
    await _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc()
        .set(favourite.toJson())
        .then((value) => Get.snackbar('Success', 'Added Successfully.'));
    Get.find<FavouriteController>().fetch();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> checkfavourite(productID) async* {
    if (kIsWeb) {
      yield* const Stream.empty(); // return empty stream on Web
    } else {
      yield* _firebaseFirestore
          .collection('favourite')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('items')
          .where('id', isEqualTo: productID)
          .snapshots();
    }
  }

  Future<List<Favourite>> getFavouriteItems() async {
    if (kIsWeb) return [];
    final snapshot =
        await _firebaseFirestore
            .collection('favourite')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('items')
            .get();
    return snapshot.docs.map((e) => Favourite.fromSnapshot(e)).toList();
  }

  Future<void> deleteitems(String? documentId) async {
    if (kIsWeb) return;
    await _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc(documentId)
        .delete()
        .then((value) => ToastWidget('Deleted Successfully', Colors.red));
  }

  Future<void> AddtoCart(UserCart userCart) async {
    if (kIsWeb) return;
    await _firebaseFirestore
        .collection('Cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc()
        .set(userCart.toJson())
        .then((value) => ToastWidget('Added Successfully', Colors.green));
  }

  Future<List<UserCart>> GetCart() async {
    if (kIsWeb) {
      return [
        UserCart(title: "Web Cart Item", price: 99, thumbnail: null),
      ]; // demo item
    }

    final snapshot =
        await _firebaseFirestore
            .collection('Cart')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('items')
            .get();

    return snapshot.docs.map((e) => UserCart.fromSnapshot(e)).toList();
  }

  Future<void> deleteCartItems(String? documentId) async {
    await _firebaseFirestore
        .collection('Cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc(documentId)
        .delete()
        .then((value) => Get.snackbar('Success', "Delete Successfully"));
  }


}
