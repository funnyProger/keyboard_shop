import 'package:flutter/foundation.dart';
import 'package:keyboard_shop/core/models/cart_model.dart';
import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'cart_product.dart';

class Cart {
  Cart._();
  static final Cart _instance = Cart._();
  static DatabaseController controller = DatabaseController();
  static List<CartProduct> _productList = [];


  static initList() async {
    try {
      _productList = await controller.getDataFromTable('cart') as List<CartProduct>;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }


  static Cart getInstance() {
    return _instance;
  }


  void add(CartProduct cartProduct) {
    if (_productList.isNotEmpty) {
      bool isNotContainsCartProduct = true;
      
      for (int i = 0; i < _productList.length; i++) {
        if (cartProduct.id == _productList[i].id) {
          _productList[i].count++;
          controller.updateTableDataById(_productList[i], 'cart');
          isNotContainsCartProduct = false;
          return;
        }
      }
      
      if(isNotContainsCartProduct) {
        _productList.add(cartProduct);
        controller.addDataToTable(cartProduct, 'cart');
      }
    } else {
      _productList.add(cartProduct);
      controller.addDataToTable(cartProduct, 'cart');
    }
  }


  void remove(int id) {
    for(int i = 0; i < _productList.length; i++) {

      if(_productList[i].id == id) {
        if(_productList[i].count == 1) {
          controller.deleteTableData(_productList[i].id, 'cart');
          _productList.removeAt(i);
          return;
        } else {
          _productList[i].count--;
          controller.updateTableDataById(_productList[i], 'cart');
        }
        getPrice();
        return;
      }

    }
  }


  void buy() {
    _productList.clear();
    controller.deleteAllTableData('cart');
  }


  String getPrice() {
    int tmp = 0;

    if (_productList.isEmpty) {
      return "Cart";
    } else {
      for (int i = 0; i < _productList.length; i++) {
        tmp = tmp + (_productList[i].price * _productList[i].count);
      }
    }

    return "To pay: ${getValidPrice(tmp)}";
  }


  List<CartProduct> getProductList() {
    return [..._productList];
  }


  bool isEmpty() {
    return _productList.isEmpty;
  }
}