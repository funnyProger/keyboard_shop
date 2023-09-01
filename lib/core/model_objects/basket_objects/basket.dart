import 'package:flutter/foundation.dart';
import 'package:keyboard_shop/core/model_objects/product_objects/product.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';
import '../../controllers/data_controller.dart';

//синглтон класс
class Basket {
  Basket._();
  static final Basket _instance = Basket._();
  static Controller controller = Controller();

  static List<Product> _productList = [];


  static initList() async {
    try {
      _productList = await controller.getBasketData();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Basket getInstance() {
    return _instance;
  }

  //добавляет товар в корзину
  void add(Product product) {
    if (_productList.isNotEmpty) {
      bool trueOrFalse = true;
      for (int i = 0; i < _productList.length; i++) {
        if (product.id == _productList[i].id) {
          _productList[i].count++;
          controller.updateBasketData(_productList[i]);
          trueOrFalse = false;
          return;
        }
      }
      if(trueOrFalse) {
        _productList.add(product);
        controller.addBasketData(product);
      }
    } else {
      _productList.add(product);
      controller.addBasketData(product);
    }
    initList();
  }

  //удаляет товар из корзины
  void remove(Product product) {
    for(int i = 0; i < _productList.length; i++) {
      if(_productList[i] == product) {
        if(_productList[i].count == 1) {
          _productList.removeAt(i);
          controller.deleteBasketData(product.id);
          return;
        } else {
          _productList[i].count--;
          controller.updateBasketData(_productList[i]);
        }
        getPrice();
        return;
      }
    }
    initList();
  }

  //очищает корзину
  void buy() {
    _productList.clear();
    controller.deleteAllBasketData();
  }

  //возвращает общую стоимость козины
  String getPrice() {
    int tmp = 0;
    if (_productList.isEmpty) {
      return "Корзина";
    } else {
      for (int i = 0; i < _productList.length; i++) {
        tmp = tmp + (_productList[i].price * _productList[i].count);
      }
    }
    return "К оплате: ${getString(tmp)}";
  }

  //возвращает список товаров корзины
  List<Product> getProductList() {
    return [..._productList];
  }

  //возвращает проверку козины на пустоту
  bool isEmpty() {
    return _productList.isEmpty;
  }

}