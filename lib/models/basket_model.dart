import 'package:flutter/foundation.dart';
import 'package:keyboard_shop/model_objects/basket.dart';
import '../model_objects/product.dart';

class BasketModel extends ChangeNotifier {

  dynamic _basketPrice = 'Корзина';
  int _basketCount = 0;

  void addToBasket(Product product) {
    var basketMap = Basket.getInstance().getMap();
    if(basketMap.containsKey(product)) {
      basketMap.update(product, (value) => value + 1);
    } else {
      basketMap[product] = 1;
    }
    totalPrice();
    changeBasketCount();
    notifyListeners();
  }

  void removeFromBasket(Product product) {
    if(getMap()[product] == 1) {
      getMap().remove(product);
    } else {
      getMap().update(product, (value) => value - 1);
    }
    totalPrice();
    changeBasketCount();
    notifyListeners();
  }

  void buy() {
    getMap().clear();
    _basketPrice = 'Корзина';
    changeBasketCount();
    notifyListeners();
  }

  Iterable<Product> getKeysList() {
    return getMap().keys.toList();
  }

  Map<Product, int> getMap() {
    return Basket.getInstance().getMap();
  }

  void totalPrice() {
    if(getMap().isEmpty) {
      _basketPrice = "Корзина";
    } else {
      _basketPrice = 0;
      getMap().forEach((key, value) {
        _basketPrice = _basketPrice + (key.price * value);
      });
      //вызов метода getString() из класса Product для преобразования стоимости
      //корзины в строку нужного вида
      _basketPrice = "К оплате: ${getString(_basketPrice)}";
    }
    notifyListeners();
  }

  void changeBasketCount() {
    _basketCount = 0;
    getMap().forEach((key, value) {
      _basketCount = _basketCount + value;
    });
    notifyListeners();
  }

  String getBasketPrice() {
    return _basketPrice;
  }

  int getBasketCount() {
    return _basketCount;
  }
}