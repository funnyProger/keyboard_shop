import 'package:flutter/material.dart';
import 'package:keyboard_shop/widgets/basket_screen_widgets/basket_listview.dart';
import 'package:keyboard_shop/widgets/first_screen_widgets/first_screen_container.dart';
import 'package:provider/provider.dart';

import '../../model_objects/product.dart';
import '../../models/basket_model.dart';
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
              child: Consumer<BasketModel> (
                builder: (context, basketModel, child) =>
                    const FirstScreenContainer().getIcon(context.watch<BasketModel>()),
              )
          ),
        ],
      ),
    );
  }

}