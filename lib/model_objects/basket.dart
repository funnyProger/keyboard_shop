//синглтон класс
import 'package:keyboard_shop/model_objects/product.dart';

class Basket {
  Basket._();
  static final Basket _instance = Basket._();

  final Map<Product, int> _map = {};

  static Basket getInstance() {
    return _instance;
  }

  //возвразает map корзины
  Map<Product, int> getMap() {
    return _instance._map;
  }


}