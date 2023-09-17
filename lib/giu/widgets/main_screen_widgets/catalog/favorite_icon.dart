import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({super.key, required this.id});
  final int id;


  @override
  Widget build(BuildContext context) {
    bool isAddToFavorites =
    context.select<FavoritesModel, bool>((favoriteModelObject) =>
        favoriteModelObject.isProductContainsInFavorites(id));

    if (isAddToFavorites) {
      return SizedBox(
          height: 25,
          width: 25,
          child: Image.asset('assets/images/favorite_selected.png')
      );
    } else {
      return SizedBox(
          height: 25,
          width: 25,
          child: Image.asset('assets/images/favorite_not_selected.png')
      );
    }
  }
}