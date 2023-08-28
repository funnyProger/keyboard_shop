import 'package:keyboard_shop/CORE/model_objects/product.dart';

//синглтон класс
class Basket {
  Basket._();
  static final Basket _instance = Basket._();

  final Map<int, int> _countMap = {};
  final Map<int, Product> _productMap = {};

  static Basket getInstance() {
    return _instance;
  }

  Map<int, int> getCountMap() {
    return _instance._countMap;
  }

  Map<int, Product> getProductMap() {
    return _instance._productMap;
  }

}