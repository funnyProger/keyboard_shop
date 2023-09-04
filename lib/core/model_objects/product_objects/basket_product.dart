class BasketProduct {
  final int id;
  final String image;
  final String name;
  final int price;
  int count;

  BasketProduct({
    this.count = 1,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
  });

  factory BasketProduct.fromSqfliteDatabase(Map<String, dynamic> map) {
    return BasketProduct(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      price: map['price'],
      count: map['count'],
    );
  }

  Map<String, dynamic> toSQLite() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'count': count,
    };
  }

}
