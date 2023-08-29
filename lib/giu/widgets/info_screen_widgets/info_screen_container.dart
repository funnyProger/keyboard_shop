import 'package:flutter/material.dart';
import 'package:keyboard_shop/GIU/widgets/first_screen_widgets/basket_icon_widget.dart';
import 'package:keyboard_shop/core/model_objects/json_data/product.dart';
import '../basket_screen_widgets/basket_widget.dart';
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
              child: const BasketIconWidget()
          ),
        ],
      ),
    );
  }

}