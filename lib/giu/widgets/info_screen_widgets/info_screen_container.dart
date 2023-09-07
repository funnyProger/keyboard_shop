import 'package:flutter/material.dart';
import 'package:keyboard_shop/GIU/widgets/first_screen_widgets/catalog/basket_icon.dart';
import 'package:keyboard_shop/giu/widgets/basket_screen_widgets/basket_screen_container.dart';
import 'info.dart';

class InfoScreenContainer extends StatelessWidget {
  const InfoScreenContainer({super.key, required this.product});
  final dynamic product;


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
                        builder: (context) => const BasketScreenContainer()),
                  );
                },
                child: const BasketIconWidget()),
          ],
        ),
      ),
    );

  }
}
