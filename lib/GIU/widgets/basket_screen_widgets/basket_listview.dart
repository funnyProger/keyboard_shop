import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../CORE/model_objects/product.dart';
import '../../../CORE/models/basket_model.dart';


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
    if(context.read<BasketModel>().getProductMap().isEmpty) {
      return const Center(
        child: Text(
            "Корзина пуста",
            style: TextStyle(fontSize: 17, color: Colors.white54),
            textDirection: TextDirection.ltr
        ),
      );
    } else {
      var list = context.read<BasketModel>().getProductList();
      return
        Stack(
          children: [
            ListView.builder(
                itemCount: list.length + 1,
                itemBuilder: (context, index) {
                  return listViewBuilder(
                      context,
                      index,
                      list,
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
  Widget listViewBuilder(BuildContext context, int index, List<Product> list) {
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
  Widget listItem(BuildContext context, int index, List<Product> list) {
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
                                context.read<BasketModel>().addToBasket(list[index]);
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
                                context.read<BasketModel>().getCountMap()[list[index].id].toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),

                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<BasketModel>().removeFromBasket(list[index]);
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