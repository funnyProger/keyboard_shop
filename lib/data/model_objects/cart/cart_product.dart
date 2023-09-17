class CartProduct {
  final int id;
  final String image;
  final String name;
  final int price;
  int count;


  CartProduct({
    this.count = 1,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
  });


  factory CartProduct.fromJson(Map<String, dynamic> map) {
    return CartProduct(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      price: map['price'],
      count: map['count'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'count': count,
    };
  }
}
