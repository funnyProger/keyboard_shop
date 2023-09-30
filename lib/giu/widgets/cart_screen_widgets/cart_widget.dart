import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/cart_model.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:keyboard_shop/data/model_objects/cart/cart_product.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/catalog/listview_item.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});


  @override
  Widget build(BuildContext context) {
    if (context.watch<CurrentUserModel>().isCurrentUserLoggedIn()) {
      if (context.watch<CartModel>().isCartEmpty()) {
        return const Center(
          child: Text("Empty",
              style: TextStyle(fontSize: 17, color: Colors.white54),
              textDirection: TextDirection.ltr),
        );
      } else {
        return Stack(
          children: [
            ListView.builder(
                itemCount: context
                    .read<CartModel>()
                    .getCartList()
                    .length + 1,
                itemBuilder: (context, index) {
                  return listViewBuilder(
                    context,
                    index,
                    context.watch<CartModel>().getCartList(),
                  );
                }
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    context.read<CartModel>().buy();
                    showSnackBar(context, 'Successfully paid');
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Buy",
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
    } else {
      return const Center(
        child: Text("Empty",
            style: TextStyle(fontSize: 17, color: Colors.white54),
            textDirection: TextDirection.ltr),
      );
    }
  }


  Widget listViewBuilder(
      BuildContext context,
      int index,
      List<CartProduct> basketProductList
      ) {
    if (index == basketProductList.length) {
      return Container(
        height: 75,
      );
    } else {
      return listItem(context, index, basketProductList);
    }
  }


  Widget listItem(BuildContext context, int index, List<CartProduct> basketProductList) {

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17), color: Colors.white),
        child: Row(
          children: [
            Expanded(
                flex: 10,
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.all(5),
                  child: Image.network(basketProductList[index].image),
                )),
            Expanded(
                flex: 9,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      basketProductList[index].name,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      textDirection: TextDirection.ltr,
                      softWrap: true,
                    ))),
            Expanded(
                flex: 9,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          getValidPrice(basketProductList[index].price),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CartModel>()
                                  .addToCart(
                                    basketProductList[index].id,
                                    basketProductList[index].userId,
                                    basketProductList[index].image,
                                    basketProductList[index].name,
                                    basketProductList[index].price,
                                  );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              alignment: Alignment.center,
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green,
                              ),
                              child: const Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(3),
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black12),
                            child: Text(
                              basketProductList[index].count.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CartModel>()
                                  .removeFromCart(basketProductList[index].id);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              alignment: Alignment.center,
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red,
                              ),
                              child: const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ],
        )
    );

  }
}