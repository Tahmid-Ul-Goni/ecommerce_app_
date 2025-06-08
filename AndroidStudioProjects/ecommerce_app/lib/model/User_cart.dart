import 'package:cloud_firestore/cloud_firestore.dart';

class UserCart {
  String? id;
  String?docId;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  UserCart(
      {this.id,
        this.title, this.docId,
        this.description,
        this.price,
        this.discountPercentage,
        this.rating,
        this.stock,
        this.brand,
        this.category,
        this.thumbnail,
        this.images});

  factory UserCart.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data= snapshot.data()!;

    return UserCart(
        brand: data['brand'],
        category: data['category'],
        description: data['description'],
        discountPercentage: (data['discountPercentage'] ?? 0).toDouble(),
        id: (data['id'] ?? [] ),
        docId: snapshot.id,
        images: data['images'],
        price: (data['price'] as num?)?.toInt() ?? 0,
        rating:( data['rating'] ?? 0).toDouble(),
        stock: data['stock'],
        thumbnail: data['thumbnail'],
        title: data['title']);
  }   Map<String,dynamic>toJson() {
    return {
      'id':id,
      'docId':docId,
      'brand':brand,
      'category': category,
      'description': description,
      'discountPercentage': discountPercentage,
      'images': images,
      'price': price,
      'rating': rating?.toDouble(),
      'stock': stock,
      'thumbnail': thumbnail,
      'title': title,

    };


  }}