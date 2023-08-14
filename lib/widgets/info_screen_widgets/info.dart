import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/product.dart';

class Info extends StatelessWidget {

  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = (ModalRoute.of(context)!.settings.arguments
        ?? Product(image: "", name: "No data", price: "No data", description: "No data")) as Product;

    return Container(
      color: Colors.black87,
      child: Container(
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
              flex: 5,
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
              flex: 1,
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
                            product.price,
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
              flex: 6,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 15),
                child: Text(
                  "Описание: \n\n${product.description}",
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

}