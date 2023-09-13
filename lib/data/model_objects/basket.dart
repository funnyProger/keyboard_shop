import 'package:flutter/foundation.dart';
import 'package:keyboard_shop/data/model_objects/basket_product.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';
import 'package:keyboard_shop/data/controllers/database_controller.dart';

class Basket {
  Basket._();
  static final Basket _instance = Basket._();
  static DatabaseController controller = DatabaseController();
  static List<BasketProduct> _productList = [];


  static initList() async {
    try {
      _productList = await controller.getDataFromTable('basket') as List<BasketProduct>;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }


  static Basket getInstance() {
    return _instance;
  }


  void add(BasketProduct basketProduct) {
    if (_productList.isNotEmpty) {
      bool isNotContainsBasketProduct = true;
      
      for (int i = 0; i < _productList.length; i++) {
        if (basketProduct.id == _productList[i].id) {
          _productList[i].count++;
          controller.updateTableData(_productList[i], 'basket');
          isNotContainsBasketProduct = false;
          return;
        }
      }
      
      if(isNotContainsBasketProduct) {
        _productList.add(basketProduct);
        controller.addDataToTable(basketProduct, 'basket');
      }
    } else {
      _productList.add(basketProduct);
      controller.addDataToTable(basketProduct, 'basket');
    }
  }


  void remove(int id) {
    for(int i = 0; i < _productList.length; i++) {

      if(_productList[i].id == id) {
        if(_productList[i].count == 1) {
          controller.deleteTableData(_productList[i].id, 'basket');
          _productList.removeAt(i);
          return;
        } else {
          _productList[i].count--;
          controller.updateTableData(_productList[i], 'basket');
        }
        getPrice();
        return;
      }

    }
  }


  void buy() {
    _productList.clear();
    controller.deleteAllTableData('basket');
  }


  String getPrice() {
    int tmp = 0;

    if (_productList.isEmpty) {
      return "Корзина";
    } else {
      for (int i = 0; i < _productList.length; i++) {
        tmp = tmp + (_productList[i].price * _productList[i].count);
      }
    }

    return "К оплате: ${getValidPrice(tmp)}";
  }


  List<BasketProduct> getProductList() {
    return [..._productList];
  }


  bool isEmpty() {
    return _productList.isEmpty;
  }
}