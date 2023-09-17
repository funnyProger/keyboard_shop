import 'base_product.dart';

class Product extends BaseProduct{

  Product({
    required super.id,
    required super.image,
    required super.name,
    required super.price,
    required super.description,
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
