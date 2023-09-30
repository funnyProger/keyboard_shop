import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/cart_model.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:keyboard_shop/data/model_objects/product/base_product.dart';
import 'package:keyboard_shop/giu/widgets/info_screen_widgets/info_screen_container.dart';
import 'package:provider/provider.dart';
import 'favorite_icon.dart';


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
                      InfoScreenContainerWidget(product: product)));
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17), color: Colors.white),
            child: Column(
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
                              if(context.read<CurrentUserModel>().isCurrentUserLoggedIn()) {
                                context
                                    .read<CartModel>()
                                    .addToCart(
                                  product.id,
                                  product.userId,
                                  product.image,
                                  product.name,
                                  product.price,
                                );
                                showSnackBar(context, 'Successfully added');
                              } else {
                                showSnackBar(context, 'Please login');
                              }
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
                                  "Add to cart",
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
                              if(context.read<CurrentUserModel>().isCurrentUserLoggedIn()) {
                                context
                                    .read<FavoritesModel>()
                                    .productDistributor(product);
                                if(context
                                    .read<FavoritesModel>()
                                    .isProductContainsInFavorites(product.name)) {
                                  showSnackBar(context, 'Successfully added');
                                }
                              } else {
                                showSnackBar(context, 'Please login');
                              }
                            },
                            child: FavoriteIconWidget(productName: product.name),
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
      child: Text(
          snackBarMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          textDirection: TextDirection.ltr
      ),
    ),
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(100),
      ),
    ),
    backgroundColor: Colors.black87,
    margin: const EdgeInsets.only(left: 110, right: 110, bottom: 30),
  );

  return snackBar;
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .removeCurrentSnackBar();
  ScaffoldMessenger.of(context)
      .showSnackBar(
      getSnackBar(message));
}