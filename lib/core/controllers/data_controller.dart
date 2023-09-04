import 'dart:async';
import 'package:keyboard_shop/core/model_objects/product_objects/basket_product.dart';
import 'package:keyboard_shop/core/model_objects/product_objects/product.dart';
import 'get_data.dart';

class GetDataInterface {
  getProductDataFromJson() {}
  initBasketDataBase() {}
  insetIntoBasketDB(BasketProduct product) {}
  getAllDataFormBasketDB() {}
  deleteDataFromBasketDB(int id) {}
  deleteAllDataFromBasketDB() {}
  updateDataInBasketDB(BasketProduct product) {}
  getDataBaseTableCount() {}
}

class Controller {
  final GetDataInterface _dataObject = GetData();

  Future<List<Product>> getProductData() async {
    return _dataObject.getProductDataFromJson();
  }

  Future<List<BasketProduct>> getBasketData() async {
    return await _dataObject.getAllDataFormBasketDB();
  }

  void deleteBasketData(int id) {
    _dataObject.deleteDataFromBasketDB(id);
  }

  void addBasketData(BasketProduct basketProduct) {
    _dataObject.insetIntoBasketDB(basketProduct);
  }

  void deleteAllBasketData() {
    _dataObject.deleteAllDataFromBasketDB();
  }

  void initBasketDB() {
    _dataObject.initBasketDataBase();
  }

  void updateBasketData(BasketProduct basketProduct) {
    _dataObject.updateDataInBasketDB(basketProduct);
  }
  Future<int> getBasketDBCount() {
    return _dataObject.getDataBaseTableCount();
  }

}
