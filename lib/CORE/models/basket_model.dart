import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model_objects/basket.dart';
import '../model_objects/product.dart';

class BasketModel extends ChangeNotifier {

  String _basketPrice = 'Корзина';

  void addToBasket(Product product) {
    var countMap = getCountMap();
    var productMap = getProductMap();

    if(countMap.containsKey(product.id)) {
      countMap.update(product.id, (value) => value + 1);
    } else {
      productMap[product.id] = product;
      countMap[product.id] = 1;
    }
    getTotalPrice();
    notifyListeners();
  }

  void removeFromBasket(Product product) {
    var countMap = getCountMap();
    var productMap = getProductMap();

    if(countMap[product.id] == 1) {
      countMap.remove(product.id);
      productMap.remove(product.id);
    } else {
      countMap.update(product.id, (value) => value - 1);
    }

    getTotalPrice();
    notifyListeners();
  }

  void buy() {
    getProductMap().clear();
    getCountMap().clear();
    _basketPrice = 'Корзина';
    notifyListeners();
  }

  List<Product> getProductList() {
    return getProductMap().values.toList();
  }

  //key - product[id], value - count
  Map<int, int> getCountMap() {
    return Basket.getInstance().getCountMap();
  }

  //key - product[id], value - product
  Map<int, Product> getProductMap() {
    return Basket.getInstance().getProductMap();
  }

  void getTotalPrice() {
    var countMap = getCountMap();
    var productMap = getProductMap();

    int tmp = 0;
    if(productMap.isEmpty && countMap.isEmpty) {
      _basketPrice = "Корзина";
    } else {
      productMap.forEach((key, value) {
        tmp = tmp + (value.price * countMap[key]!);
      });
      //вызов метода getString() из класса Product для преобразования стоимости
      //корзины в строку нужного вида

      _basketPrice = "К оплате: ${getString(tmp)}";
    }
  }

  String getBasketPrice() {
    return _basketPrice;
  }

  int getBasketCount() {
    return getCountMap().values.toList().sum;
  }

}