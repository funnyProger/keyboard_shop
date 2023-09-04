import 'package:flutter/foundation.dart';
import 'package:keyboard_shop/core/model_objects/product_objects/basket_product.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';
import '../../controllers/data_controller.dart';

//синглтон класс
class Basket {
  Basket._();
  static final Basket _instance = Basket._();
  static Controller controller = Controller();

  static List<BasketProduct> _productList = [];


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
  void add(BasketProduct basketProduct) {
    if (_productList.isNotEmpty) {
      bool trueOrFalse = true;
      for (int i = 0; i < _productList.length; i++) {
        if (basketProduct.id == _productList[i].id) {
          _productList[i].count++;
          controller.updateBasketData(_productList[i]);
          trueOrFalse = false;
          return;
        }
      }
      if(trueOrFalse) {
        _productList.add(basketProduct);
        controller.addBasketData(basketProduct);
      }
    } else {
      _productList.add(basketProduct);
      controller.addBasketData(basketProduct);
    }
    initList();
  }

  //удаляет товар из корзины
  void remove(int id) {
    for(int i = 0; i < _productList.length; i++) {
      if(_productList[i].id == id) {
        if(_productList[i].count == 1) {
          controller.deleteBasketData(_productList[i].id);
          _productList.removeAt(i);
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
  List<BasketProduct> getProductList() {
    return [..._productList];
  }

  //возвращает проверку козины на пустоту
  bool isEmpty() {
    return _productList.isEmpty;
  }

}