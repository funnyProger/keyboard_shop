import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_shop/models/basket_model.dart';
import 'package:provider/provider.dart';
import '../../model_objects/product.dart';

//widget class
class BasketWidget extends StatefulWidget {
  const BasketWidget({super.key});

  @override
  State<BasketWidget> createState() => _ListState();
}

//state widget class
class _ListState extends State<BasketWidget> {

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Container(
            color: Colors.black87,
            padding: const EdgeInsets.all(7),
            child: Consumer<BasketModel> (
              builder: (context, basketModel, child) => selectWidget(context, basketModel, child),
            ),
        ),
        appBar: AppBar(
          title: Consumer<BasketModel> (
            builder: (context, basketModel, child) =>
                Text(
                  basketModel.getBasketPrice(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  textDirection: TextDirection.ltr,
                ),
          ),
          backgroundColor: Colors.black,
        ),
      );
  }

  Widget selectWidget(BuildContext context, BasketModel basketModel, Widget? child) {
    if(child != null) {
      return child;
    } else if(BasketModel().getMap().isEmpty) {
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
                itemCount: basketModel.getKeysList().length + 1,
                itemBuilder: (context, index) {
                  return listViewBuilder(
                      context,
                      basketModel,
                      index,
                      basketModel.getKeysList() as List<Product>);
                }),
            Container(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Provider.of<BasketModel>(context, listen: false).buy();
                      Fluttertoast.showToast(
                        msg: "Успешно оплачено",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 15,
                      );
                    });
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
  Widget listViewBuilder(BuildContext context, BasketModel basketModel, int index, List<Product> list) {
    if(index == list.length) {
      return Container(
        height: 75,
      );
    } else {
      return
        listItem(index, basketModel, list);
    }
  }

  //listViewItem
  Widget listItem(int index, BasketModel basketModel, List<Product> list) {
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
                                Provider.of<BasketModel>(context, listen: false).addToBasket(list[index]);
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
                                basketModel.getMap()[list[index]].toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),

                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<BasketModel>(context, listen: false).removeFromBasket(list[index]);
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