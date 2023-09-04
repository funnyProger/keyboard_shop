import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/controllers/data_controller.dart';
import 'package:keyboard_shop/core/model_objects/basket_objects/basket.dart';
import 'package:keyboard_shop/core/model_objects/product_objects/basket_product.dart';

class BasketModel extends ChangeNotifier {
  final Basket _basket = Basket.getInstance();

  void initBasketFromDB() {
    Basket.initList();
  }

  void addToBasket(int id, String image, String name, int price) {
    _basket.add(
        BasketProduct(
            id: id,
            image: image,
            name: name,
            price: price
        )
    );
    notifyListeners();
  }

  void removeFromBasket(int id) {
    _basket.remove(id);
    notifyListeners();
  }

  void buy() {
    _basket.buy();
    notifyListeners();
  }

  String getBasketPrice() {
    return _basket.getPrice();
  }

  Future<int> getBasketCount() async {
    return Controller().getBasketDBCount();
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