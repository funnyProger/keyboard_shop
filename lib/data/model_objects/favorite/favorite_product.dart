import 'package:keyboard_shop/data/model_objects/product/base_product.dart';

class FavoriteProduct implements BaseProduct {
  bool isAddToFavorite;
  @override
  String description;
  @override
  int id;
  @override
  String image;
  @override
  String name;
  @override
  int price;


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


  @override
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
