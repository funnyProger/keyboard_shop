import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_shop/core/model_objects/product_objects/basket_product.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';
import 'package:provider/provider.dart';


class BasketWidget extends StatelessWidget {
  const BasketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Container(
            color: Colors.black87,
            padding: const EdgeInsets.all(7),
            child: selectWidget(context)
        ),
        appBar: AppBar(
          title: Text(
            context.watch<BasketModel>().getBasketPrice(),
            style: const TextStyle(fontSize: 20, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
          backgroundColor: Colors.black,
        ),
      );
  }

  Widget selectWidget(BuildContext context) {
    if(context.watch<BasketModel>().basketIsEmpty()) {
      return const Center(
        child: Text(
            "Корзина пуста",
            style: TextStyle(fontSize: 17, color: Colors.white54),
            textDirection: TextDirection.ltr
        ),
      );
    } else {
      return
        Stack(
          children: [
            ListView.builder(
                itemCount: context.read<BasketModel>().getBasketList().length + 1,
                itemBuilder: (context, index) {
                  return listViewBuilder(
                      context,
                      index,
                      context.watch<BasketModel>().getBasketList(),
                  );
                }),
            Container(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    context.read<BasketModel>().buy();
                    Fluttertoast.showToast(
                      msg: "Успешно оплачено",
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 15,
                    );
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
                      "Купить",
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

  //listViewBuilder
  Widget listViewBuilder(BuildContext context, int index, List<BasketProduct> list) {
    if(index == list.length) {
      return Container(
        height: 75,
      );
    } else {
      return
        listItem(context, index, list);
    }
  }

  //listViewItem
  Widget listItem(BuildContext context, int index, List<BasketProduct> list) {
    return
      Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: Colors.white
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 10,
                  child: Container(
                    height: 90,
                    padding: const EdgeInsets.all(5),
                    child: Image.network(list[index].image),
                  )
              ),
              Expanded(
                  flex: 9,
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        list[index].name,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        textDirection: TextDirection.ltr,
                        softWrap: true,
                      )
                  )
              ),
              Expanded(
                  flex: 9,
                  child: Row(
                    children: [
                      Expanded(
                        flex:3,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            getString(list[index].price),
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
                                context.read<BasketModel>().addToBasket(
                                  list[index].id,
                                  list[index].image,
                                  list[index].name,
                                  list[index].price,
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
                                  color: Colors.black12
                              ),
                              child: Text(
                                list[index].count.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),

                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<BasketModel>().removeFromBasket(
                                  list[index].id,
                                );
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