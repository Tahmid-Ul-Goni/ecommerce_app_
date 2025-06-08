import 'package:cloud_firestore/cloud_firestore.dart';

class Favourite {
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

  Favourite(
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

  factory Favourite.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data= snapshot.data()!;

    return Favourite(
        brand: data['brand'],
        category: data['category'],
        description: data['description'],
        discountPercentage: (data['discountPercentage'] ?? 0).toDouble(),
        id: (data['id'] ?? 0) ,
        docId: snapshot.id,
        images: data['images'],
        price: data['price'],
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