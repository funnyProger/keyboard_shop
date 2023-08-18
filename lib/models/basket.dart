import 'package:keyboard_shop/models/product.dart';

//синглтон класс
class Basket {
  Basket._();
  static final Basket _instance = Basket._();

  Map<Product, int> map = {};

  static Basket getInstance() {
    return _instance;
  }

  void addToBasket(Product product) {
    if(_instance.map.containsKey(product)) {
      _instance.map.update(product, (value) => value + 1);
    } else {
      _instance.map[product] = 1;
    }
  }
  void removeFromBasket(Product product) {
    if(_instance.map[product] == 1) {
      _instance.map.remove(product);
    } else {
      _instance.map.update(product, (value) => value - 1);
    }
  }

  //возвразает map корзины
  Map<Product, int> getMap() {
    return _instance.map;
  }

  //возвращает список ключей map, где ключ - объект типа Product
  Iterable<Product> getKeys() {
    return _instance.map.keys;
  }

  //отчищает корзину
  void buy() {
    _instance.map.clear();
  }
}