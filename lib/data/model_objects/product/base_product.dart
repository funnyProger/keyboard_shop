import 'package:keyboard_shop/data/model_objects/database/database_entity.dart';

abstract class BaseProduct extends DbEntity {
  int id;
  String userId = '';
  String image;
  String name;
  int price;
  String description;

  BaseProduct({
    required this.id,
    required this.userId,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });
}