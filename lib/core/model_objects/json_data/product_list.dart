import 'package:json_annotation/json_annotation.dart';
import 'package:keyboard_shop/core/model_objects/json_data/product.dart';

part 'product_list.g.dart';

@JsonSerializable()
class ProductList {
  List<Product> products;

  ProductList({
    required this.products
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => _$ProductListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListToJson(this);
}
