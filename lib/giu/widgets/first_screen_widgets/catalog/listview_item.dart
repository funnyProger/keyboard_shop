import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/data/model_objects/base_product.dart';
import 'package:keyboard_shop/giu/widgets/first_screen_widgets/catalog/favorite_icon.dart';
import 'package:keyboard_shop/giu/widgets/info_screen_widgets/info_screen_container.dart';
import 'package:provider/provider.dart';


class ListViewItemWidget extends StatelessWidget {
  const ListViewItemWidget({super.key, required this.product});
  final BaseProduct product;


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      InfoScreenContainer(product: product)));
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 16,
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      child: Image.network(product.image)),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                        padding: const EdgeInsets.only(left: 9),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          getValidPrice(product.price),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.ltr,
                        ))),
                Expanded(
                    flex: 6,
                    child: Container(
                        padding:
                            const EdgeInsets.only(left: 10, top: 5, right: 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          textDirection: TextDirection.ltr,
                          softWrap: true,
                        ))),
                Expanded(
                    flex: 6,
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              context
                                  .read<BasketModel>()
                                  .addToBasket(
                                    product.id,
                                    product.image,
                                    product.name,
                                    product.price,
                                  );
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                  getSnackBar('Успешно дабавлено'));
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 1, bottom: 10),
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.indigoAccent),
                                child: const Text(
                                  "В корзину",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            )),
                        Positioned(
                          top: 6,
                          right: 12,
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<FavoritesModel>()
                                  .productDistributor(product);
                              if(context
                                  .read<FavoritesModel>()
                                  .isProductContainsInFavorites(product.id)) {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                    getSnackBar('Успешно дабавлено'));
                              }
                            },
                            child: FavoriteIcon(id: product.id),
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
        )
    );

  }
}


SnackBar getSnackBar(String snackBarMessage) {

  final snackBar = SnackBar(
    content: Center(
      child: Text(snackBarMessage,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          textDirection: TextDirection.ltr),
    ),
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
    backgroundColor: Colors.green,
    margin: const EdgeInsets.only(left: 100, right: 100),
  );

  return snackBar;
}
