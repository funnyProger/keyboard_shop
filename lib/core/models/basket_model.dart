import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/model_objects/basket_objects/basket.dart';
import 'package:keyboard_shop/core/model_objects/basket_objects/basket_product.dart';
import 'package:keyboard_shop/core/model_objects/json_data/product.dart';

class BasketModel extends ChangeNotifier {
  final Basket _basket = Basket.getInstance();

  void addToBasket(int id, Product product) {
    _basket.add(id, product);
    notifyListeners();
  }

  void removeFromBasket(int id, Product product) {
    _basket.remove(id, product);
    notifyListeners();
  }

  void buy() {
    _basket.buy();
    notifyListeners();
  }

  String getBasketPrice() {
    return _basket.getPrice();
  }

  int getBasketCount() {
    return _basket.getCount();
  }

  List<BasketProduct> getBasketList() {
    return _basket.getProductList();
  }

  bool basketIsEmpty() {
    return _basket.isEmpty();
  }
}

//преобразует цену типа Int в тип String нужного вида
String getString(int price) {
  String str = price.toString();
  List<String> listChar = str.split('').toList();
  str = '';
  for(int i = 0; i <= listChar.length - 1; i++) {
    if(i == 1 && listChar.length == 5) {
      str = '$str${listChar[i]} ';
    } else if(i == 2 && listChar.length == 6) {
      str = '$str${listChar[i]} ';
    } else if((i == 0 || i == 3) && listChar.length == 7) {
      str = '$str${listChar[i]} ';
    } else if(i == listChar.length - 1) {
      str = '$str${listChar[i]} ₽';
    } else {
      str = str + listChar[i];
    }
  }
  return str;
}