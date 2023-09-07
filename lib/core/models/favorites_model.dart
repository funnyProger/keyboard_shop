import 'package:flutter/material.dart';
import 'package:keyboard_shop/data/model_objects/favorite_product.dart';
import 'package:keyboard_shop/data/model_objects/favorites.dart';
import 'package:keyboard_shop/data/model_objects/product.dart';

class FavoritesModel extends ChangeNotifier {
  final Favorites _favorites = Favorites.getInstance();


  void initFavoritesFromDB() {
    Favorites.initList();
  }


  void productDistributor(var product) {
    if(isProductContainsInFavorites(product.id)) {
      deleteFromFavorites(product.id);
    } else {
      addToFavorites(product);
    }
    notifyListeners();
  }


  bool isProductContainsInFavorites(int id) {
    bool isProductContains = false;
    List<FavoriteProduct> favoriteProductList = getFavoriteProductList();
    for(int i = 0; i < favoriteProductList.length; i++) {
      if(favoriteProductList[i].id == id) {
        isProductContains = true;
      }
    }
    return isProductContains;
  }


  void addToFavorites(Product product) {
    FavoriteProduct favoriteProduct = createAndGetFavoriteProduct(product);
    _favorites.add(favoriteProduct);
  }


  FavoriteProduct createAndGetFavoriteProduct(Product product) {
    return FavoriteProduct(
        id: product.id,
        image: product.image,
        name: product.name,
        price: product.price,
        description: product.description,
        isAddToFavorite: true,
    );
  }


  void deleteFromFavorites(int id) {
    _favorites.delete(id);
  }


  List<FavoriteProduct> getFavoriteProductList() {
    return _favorites.getFavorites();
  }


  bool isFavoritesEmpty() {
    return _favorites.isEmpty();
  }
}