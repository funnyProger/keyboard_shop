import 'package:flutter/foundation.dart';

class FavoriteProduct with ChangeNotifier {
  final int id;
  final String image;
  final String name;
  final int price;
  final String description;
  bool isAddToFavorite;


  FavoriteProduct({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    this.isAddToFavorite = false,
  });


  factory FavoriteProduct.fromJson(Map<String, dynamic> map) {
    return FavoriteProduct(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
