import 'package:flutter/material.dart';
import '../../../CORE/model_objects/product.dart';
import '../basket_screen_widgets/basket_listview.dart';
import 'basket_icon_widget.dart';
import 'product_listview.dart';

class FirstScreenContainer extends StatelessWidget {
  const FirstScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        padding: const EdgeInsets.all(7),
        child: ListWidget(list: getList(NewID())),
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
            child: const BasketIconWidget(),
          ),
        ],
      ),
    );
  }
}