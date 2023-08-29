import 'package:keyboard_shop/core/model_objects/product_objects/product.dart';

class BasketProduct {
  final Product product;
  late int count;

  BasketProduct({
    required this.product,
  }) {
    count = 1;
  }

}

