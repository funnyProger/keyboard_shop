import 'package:flutter/material.dart';
import 'package:keyboard_shop/widgets/basket_screen_widgets/basket_listview.dart';
import '../../models/product.dart';
import 'product_listview.dart';

class FirstScreenContainer extends StatelessWidget {
  const FirstScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        padding: const EdgeInsets.all(7),
        child: ListWidget(list: getList()),
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