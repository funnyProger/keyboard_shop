import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keyboard_shop/models/basket_model.dart';
import 'package:keyboard_shop/widgets/basket_screen_widgets/basket_listview.dart';
import 'package:provider/provider.dart';
import '../../model_objects/product.dart';
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
            child: Consumer<BasketModel> (
              builder: (context, basketModel, child) => getIcon(context, basketModel, child),
            )
          ),
        ],
      ),
    );
  }

  Widget getIcon(BuildContext context, BasketModel basketModel, Widget? child) {
    if(BasketModel().getMap().isEmpty) {
      return
        Container(
          width: 29,
          margin: const EdgeInsets.only(right: 15),
          child: Image.asset('assets/images/basket.png'),
        );
    } else {
      return
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 29,
              margin: const EdgeInsets.only(right: 15),
              child: Image.asset('assets/images/basket.png'),
            ),
            Positioned(
                left: 20,
                top: 10,
                child: Container(
                  alignment: Alignment.center,
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red,
                  ),
                  child: Text(
                    basketModel.basketCount.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                )
            )
          ],
        );
    }
  }
}