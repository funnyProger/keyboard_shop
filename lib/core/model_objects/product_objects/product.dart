class Product {
  final int id;
  final String image;
  final String name;
  final int price;
  final String description;

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
