import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_shop/core/model_objects/product_objects/product.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';
import 'package:provider/provider.dart';


class InfoWidget extends StatelessWidget {
  final Product product;

  const InfoWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    return
      Container(
        margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25)
          ),
          color: Colors.black87,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Image.network(product.image),
                  )
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
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
                              style: const TextStyle(fontSize: 21, color: Colors.white),
                              textDirection: TextDirection.ltr,
                              softWrap: true,
                            ),
                          )
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          alignment: Alignment.topCenter,
                          child: Text(
                            getString(product.price),
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Expanded(
              flex: 11,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 80),
                    child: Text(
                      "Описание: \n\n${product.description}",
                      style: const TextStyle(fontSize: 17, color: Colors.white),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        context.read<BasketModel>().addToBasket(product);
                        Fluttertoast.showToast(
                          msg: "Успешно добавлено",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 15,
                        );
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
                          "В корзину",
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
              ),
            )

          ],
        )
    );


  }

}