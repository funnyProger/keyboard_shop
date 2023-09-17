import 'package:keyboard_shop/data/model_objects/product/base_product.dart';

class FavoriteProduct extends BaseProduct{
  bool isAddToFavorite;


  FavoriteProduct({
    required super.id,
    required super.image,
    required super.name,
    required super.price,
    required super.description,
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
