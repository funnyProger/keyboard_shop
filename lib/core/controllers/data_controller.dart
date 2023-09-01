import 'dart:async';
import '../model_objects/product_objects/product.dart';
import 'get_data.dart';

class GetDataInterface {
  getProductDataFromJson() {}
  initBasketDataBase() {}
  insetIntoBasketDB(Product product) {}
  getAllDataFormBasketDB() {}
  deleteDataFromBasketDB(int id) {}
  deleteAllDataFromBasketDB() {}
  updateDataInBasketDB(Product product) {}
  getDataBaseTableCount() {}
}

class Controller {
  final GetDataInterface _dataObject = GetData();

  Future<List<Product>> getProductData() async {
    return _dataObject.getProductDataFromJson();
  }

  Future<List<Product>> getBasketData() async {
    return await _dataObject.getAllDataFormBasketDB();
  }

  void deleteBasketData(int id) {
    _dataObject.deleteDataFromBasketDB(id);
  }

  void addBasketData(Product product) {
    _dataObject.insetIntoBasketDB(product);
  }

  void deleteAllBasketData() {
    _dataObject.deleteAllDataFromBasketDB();
  }

  void initBasketDB() {
    _dataObject.initBasketDataBase();
  }

  void updateBasketData(Product product) {
    _dataObject.updateDataInBasketDB(product);
  }
  Future<int> getBasketDBCount() {
    return _dataObject.getDataBaseTableCount();
  }

}
