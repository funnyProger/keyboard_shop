import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({super.key, required this.productName});
  final String productName;


  @override
  Widget build(BuildContext context) {
    bool isAddToFavorites =
    context.select<FavoritesModel, bool>((favoriteModelObject) =>
        favoriteModelObject.isProductContainsInFavorites(productName));

    if(context.watch<CurrentUserModel>().isCurrentUserLoggedIn()) {
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
    } else {
      return SizedBox(
          height: 25,
          width: 25,
          child: Image.asset('assets/images/favorite_not_selected.png')
      );
    }

  }
}