import 'package:keyboard_shop/data/model_objects/product/base_product.dart';

class CartProduct implements BaseProduct {
  @override
  int id;
  @override
  String userId;
  @override
  String image;
  @override
  String name;
  @override
  int price;
  @override
  String description = '';
  int count;


  CartProduct({
    this.count = 1,
    required this.id,
    required this.userId,
    required this.image,
    required this.name,
    required this.price,
  });


  factory CartProduct.fromJson(Map<String, dynamic> map) {
    return CartProduct(
      id: map['id'],
      userId: map['userId'],
      image: map['image'],
      name: map['name'],
      price: map['price'],
      count: map['count'],
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'image': image,
      'name': name,
      'price': price,
      'count': count,
    };
  }
}
