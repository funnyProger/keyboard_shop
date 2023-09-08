import 'package:flutter/foundation.dart';
import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'package:keyboard_shop/data/model_objects/favorite_product.dart';

class Favorites {
  Favorites._();
  static final Favorites _instance = Favorites._();
  static DatabaseController controller = DatabaseController();
  static List<FavoriteProduct> _favoritesList = [];


  static initList() async {
    print(_favoritesList);
    try {
      _favoritesList = await controller.getDataFromTable('favorites') as List<FavoriteProduct>;
      print(_favoritesList);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }


  static Favorites getInstance() {
    return _instance;
  }


  List<FavoriteProduct> getFavorites() {
    return [..._favoritesList];
  }


  void add(FavoriteProduct favoriteProduct) {
    _favoritesList.add(favoriteProduct);
    controller.addDataToTable(favoriteProduct, 'favorites');
    initList();
  }


  void delete(int id) {
    for(int i = 0; i < _favoritesList.length; i++) {
      if (_favoritesList[i].id == id) {
        _favoritesList.remove(_favoritesList[i]);
        controller.deleteTableData(id, 'favorites');
        return;
      }
    }
    initList();
  }


  bool isEmpty() {
    return _favoritesList.isEmpty;
  }
}