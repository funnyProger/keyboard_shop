import 'base_product.dart';

class Product implements BaseProduct {
  @override
  String description;
  @override
  int id;
  @override
  String userId = '';
  @override
  String image;
  @override
  String name;
  @override
  int price;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        price: json['price'],
        description: json['description'],
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'image': image,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
