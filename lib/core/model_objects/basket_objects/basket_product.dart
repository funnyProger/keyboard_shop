import 'package:keyboard_shop/core/model_objects/json_data/product.dart';

class BasketProduct {
  final Product product;
  late int count;

  BasketProduct({
    required this.product,
  }) {
    count = 1;
  }

}

