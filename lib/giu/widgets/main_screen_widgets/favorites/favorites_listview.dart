import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/catalog/listview_item.dart';
import 'package:provider/provider.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});


  @override
  Widget build(BuildContext context) {

    if(context.watch<FavoritesModel>().isFavoritesEmpty()) {
      return const Center(
        child: Text(
            "Favorites",
            style: TextStyle(fontSize: 17, color: Colors.white54),
            textDirection: TextDirection.ltr
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return ListViewItemWidget(
              product: context
                  .watch<FavoritesModel>()
                  .getFavoriteProductList()[index],
          );
        },
        itemCount: context
            .watch<FavoritesModel>()
            .getFavoriteProductList()
            .length,
      );
    }

  }
}