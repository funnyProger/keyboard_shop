import 'package:keyboard_shop/core/model_objects/basket_objects/basket_product.dart';
import 'package:keyboard_shop/core/model_objects/json_data/product.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';

//синглтон класс
class Basket {
  Basket._();
  static final Basket _instance = Basket._();

  final Map<int, BasketProduct> _productMap = {};

  static Basket getInstance() {
    return _instance;
  }

  //добавляет товар в корзину
  void add(int id, Product product) {
    if (_productMap.keys.contains(id)) {
      _productMap[id]?.count++;
    } else {
      _productMap[id] = BasketProduct(product: product);
    }
    getPrice();
  }

  //удадяет товар из корзины
  void remove(int id, Product product) {
    if(_productMap[id]?.count == 1) {
      _productMap.remove(id);
    } else {
      _productMap[id]?.count--;
    }
    getPrice();
  }

  //очищает корзину
  void buy() {
    _productMap.clear();
  }

  //возвращает общую стоимость козины
  String getPrice() {
    int tmp = 0;
    if(_productMap.isEmpty) {
      return "Корзина";
    } else {
      _productMap.forEach((key, value) {
      tmp = tmp + (value.count * value.product.price);
    });
      return "К оплате: ${getString(tmp)}";
    }
  }

  //возвращает количество товаров в козине
  int getCount() {
    int count  = 0;
    _productMap.forEach((key, value) {
      count = count + value.count;
    });
    return count;
  }

  //возвращает список товаров корзины
  List<BasketProduct> getProductList() {
    return _productMap.values.toList();
  }

  //возвращает проверку козины на пустоту
  bool isEmpty() {
    if(_productMap.isEmpty) {
      return true;
    } else {
      return false;
    }
  }


}