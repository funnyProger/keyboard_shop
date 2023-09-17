abstract class BaseProduct {
  int id;
  String image;
  String name;
  int price;
  String description;

  BaseProduct({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });
}