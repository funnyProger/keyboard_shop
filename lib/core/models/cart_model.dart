import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/data/model_objects/cart/cart.dart';
import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'package:keyboard_shop/data/model_objects/cart/cart_product.dart';

class CartModel extends ChangeNotifier {
  final Cart _cart = Cart.getInstance();


  void addToCart(int id, String image, String name, int price) {
    _cart.add(
        CartProduct(
            id: id,
            image: image,
            name: name,
            price: price
        )
    );
    notifyListeners();
  }


  void removeFromCart(int id) {
    _cart.remove(id);
    notifyListeners();
  }


  void buy() {
    _cart.buy();
    notifyListeners();
  }


  String getCartPrice() {
    return _cart.getPrice();
  }


  Future<int> getCartCount() async {
    return DatabaseController().getTableCount('cart');
  }


  List<CartProduct> getCartList() {
    return _cart.getProductList();
  }


  bool isCartEmpty() {
    return _cart.isEmpty();
  }
}


String getValidPrice(int price) {
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