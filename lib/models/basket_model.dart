import 'package:flutter/cupertino.dart';
import 'package:keyboard_shop/model_objects/basket.dart';
import '../model_objects/product.dart';

class BasketModel extends ChangeNotifier {

  late dynamic basketPrice = 'Корзина';
  late int basketCount = 0;

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
    var basketMap = Basket.getInstance().getMap();
    if(basketMap[product] == 1) {
      basketMap.remove(product);
    } else {
      basketMap.update(product, (value) => value - 1);
    }
    totalPrice();
    changeBasketCount();
    notifyListeners();
  }

  void buy() {
    var basketMap = Basket.getInstance().getMap();
    basketMap.clear();
    changeBasketCount();
    notifyListeners();
  }

  Iterable<Product> getKeysList() {
    var basketMap = Basket.getInstance().getMap();
    return basketMap.keys.toList();
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