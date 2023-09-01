class Product {
  final int id;
  final String image;
  final String name;
  final int price;
  final String description;
  int count;

  Product({
    this.count = 1,
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

  factory Product.fromSqfliteDatabase(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        image: map['image'],
        name: map['name'],
        price: map['price'],
        description: map['description'],
        count: map['count'],
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

  Map<String, dynamic> toSQLite() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      'count': count,
    };
  }

}
