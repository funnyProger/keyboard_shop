import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/product.dart';
import 'package:keyboard_shop/widgets/basket_screen_widgets/basket_listview.dart';

import 'info.dart';

class InfoScreenContainer extends StatelessWidget {
  final Product product;
  const InfoScreenContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: InfoWidget(product: product),
      ),
      appBar: AppBar(
        title: const Text(
          "Keyboard Shop",
          style: TextStyle(fontSize: 20, color: Colors.white),
          textDirection: TextDirection.ltr,
        ),
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BasketWidget()
                ),
              );
            },
            child: Container(
              height: 29,
              width: 29,
              margin: const EdgeInsets.only(right: 15),
              child: Image.asset('assets/images/basket.png'),
            ),
          ),
        ],
      ),
    );
  }

}