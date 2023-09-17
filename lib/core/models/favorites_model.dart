import 'package:flutter/material.dart';
import 'package:keyboard_shop/data/model_objects/product/base_product.dart';
import 'package:keyboard_shop/data/model_objects/favorite/favorite_product.dart';
import 'package:keyboard_shop/data/model_objects/favorite/favorites.dart';

class FavoritesModel extends ChangeNotifier {
  final Favorites _favorites = Favorites.getInstance();


  void productDistributor<T extends BaseProduct> (T product) {
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
        image: product.image,
        name: product.name,
        price: product.price,
        description: product.description,
        isAddToFavorite: true,
      );
    }
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