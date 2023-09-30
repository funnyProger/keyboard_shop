import 'package:flutter/material.dart';
import 'package:keyboard_shop/data/get_data/shared_preferences/shared_preferences_data.dart';
import 'package:keyboard_shop/data/model_objects/product/base_product.dart';
import 'package:keyboard_shop/data/model_objects/favorite/favorite_product.dart';
import 'package:keyboard_shop/data/model_objects/favorite/favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesModel extends ChangeNotifier {
  final Favorites _favorites = Favorites.getInstance();

  void updateData() {
    notifyListeners();
  }


  Future<void> productDistributor<T extends BaseProduct> (T product) async {
    if(isProductContainsInFavorites(product.name)) {
      deleteFromFavorites(product.id, product.name);
    } else {

      SharedPreferences sharPref = await SharedPreferencesData().sharedPreferences;
      String userId =  sharPref.getString('currentUserName') ?? '';
      product.userId = userId;
      addToFavorites(product);

    }
    notifyListeners();
  }


  bool isProductContainsInFavorites(String productName) {
    bool isProductContains = false;
    List<FavoriteProduct> favoriteProductList = getFavoriteProductList();
    for(int i = 0; i < favoriteProductList.length; i++) {
      if(favoriteProductList[i].name == productName) {
        isProductContains = true;
      }
    }
    return isProductContains;
  }


  void addToFavorites<T extends BaseProduct> (T product) {
    FavoriteProduct favoriteProduct = _createAndGetFavoriteProduct(product);
    _favorites.add(favoriteProduct);
  }


  FavoriteProduct _createAndGetFavoriteProduct<T extends BaseProduct>(T product) {
    if(product is FavoriteProduct) {
      product.isAddToFavorite = true;
      return product;
    } else {
      return FavoriteProduct(
        id: product.id,
        userId: product.userId,
        image: product.image,
        name: product.name,
        price: product.price,
        description: product.description,
        isAddToFavorite: true,
      );
    }
  }


  void deleteFromFavorites(int id, String productName) {
    _favorites.delete(id, productName);
  }


  List<FavoriteProduct> getFavoriteProductList() {
    return _favorites.getFavorites();
  }


  bool isFavoritesEmpty() {
    return _favorites.isEmpty();
  }
}