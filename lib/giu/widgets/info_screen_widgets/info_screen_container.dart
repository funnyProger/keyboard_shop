import 'package:flutter/material.dart';
import 'package:keyboard_shop/data/model_objects/product/base_product.dart';
import 'package:keyboard_shop/giu/widgets/cart_screen_widgets/cart_screen_container.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/catalog/cart_icon.dart';
import 'info.dart';

class InfoScreenContainerWidget extends StatelessWidget {
  const InfoScreenContainerWidget({super.key, required this.product});
  final BaseProduct product;


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        body: InfoWidget(product: product),
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
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreenContainerWidget()),
                  );
                },
                child: const CartIconWidget()),
          ],
        ),
      ),
    );

  }
}