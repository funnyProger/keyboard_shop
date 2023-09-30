import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/cart_model.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:keyboard_shop/data/model_objects/product/base_product.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/catalog/favorite_icon.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/catalog/listview_item.dart';
import 'package:provider/provider.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, required this.product});
  final BaseProduct product;


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25), topRight: Radius.circular(25)
                ),
                color: Colors.black87,
              ),
              child: Column(
                children: [
                  Container(
                      height: 300,
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.network(product.image),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: GestureDetector(
                                onTap: () {
                                  if (context
                                      .read<CurrentUserModel>()
                                      .isCurrentUserLoggedIn()) {
                                    context
                                        .read<FavoritesModel>()
                                        .productDistributor(product);
                                  } else {
                                    showSnackBar(context, 'Please login');
                                  }
                                },
                                child: FavoriteIconWidget(productName: product.name),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                    height: 70,
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Container(
                              padding: const EdgeInsets.only(top: 10),
                              alignment: Alignment.topLeft,
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                    fontSize: 21, color: Colors.white),
                                textDirection: TextDirection.ltr,
                                softWrap: true,
                              ),
                            )),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            alignment: Alignment.topCenter,
                            child: Text(
                              getValidPrice(product.price),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 5, right: 15, bottom: 80),
                    child: Text(
                      "Description: \n\n${product.description}",
                      style: const TextStyle(fontSize: 17, color: Colors.white),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              )
          ),
        ),
        Container(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
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
                height: 50,
                width: 130,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  "Add to cart",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            )
        )
      ],
    );

  }
}