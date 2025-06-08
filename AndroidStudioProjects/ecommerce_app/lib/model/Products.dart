import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String id;
  String brand;
  final List images;
  final String thumbnail;
  final String description;
  final int price;
  final String title;

  Products( {
    required this.id,
    required this.brand,
    required this.price,
    required this.description,
    required this.images,
    required this.thumbnail,
      required this.title,

  });

  factory Products.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    {
      final data = snapshot.data()!;
      return Products(
        id:snapshot.id  ?? '',
        brand: data["brand"] ?? '',
        price: data["price"] ?? 0,
        description: data["description"] ?? '',
        thumbnail: data["thumbnail"] ?? '',
        images: data['images'] ?? [],
          title: data['title'] ?? '',

      );
    }
  }
  Future<Map<String, Object>> toMap() async {
  return {
    'id': id,
    'title': title,
    'description': description,
    'brand': brand,
    'price': price,
    'thumbnail': thumbnail,
    'images': images,
  };
}


}