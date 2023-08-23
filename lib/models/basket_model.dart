import 'package:flutter/foundation.dart';
import 'package:keyboard_shop/model_objects/basket.dart';
import '../model_objects/product.dart';

class BasketModel extends ChangeNotifier {

  dynamic basketPrice = 'Корзина';
  int basketCount = 0;

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
    basketPrice = 'Корзина';
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
      basketPrice = "Корзина";
    } else {
      basketPrice = 0;
      getMap().forEach((key, value) {
        basketPrice = basketPrice + (key.price * value);
      });
      //вызов метода getString() из класса Product для преобразования стоимости
      //корзины в строку нужного вида
      basketPrice = "К оплате: ${getString(basketPrice)}";
    }
    notifyListeners();
  }

  void changeBasketCount() {
    basketCount = 0;
    getMap().forEach((key, value) {
      basketCount = basketCount + value;
    });
    notifyListeners();
  }
}