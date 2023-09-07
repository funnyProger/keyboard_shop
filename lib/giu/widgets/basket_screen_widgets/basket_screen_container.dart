import 'package:flutter/material.dart';
import 'package:keyboard_shop/GIU/widgets/basket_screen_widgets/basket_widget.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';
import 'package:provider/provider.dart';

class BasketScreenContainer extends StatelessWidget {
  const BasketScreenContainer({super.key});


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          return true;
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
          body: Container(
            padding: const EdgeInsets.all(7),
            child: const BasketWidget(),
          ),
          appBar: AppBar(
            title: Text(
              context.watch<BasketModel>().getBasketPrice(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textDirection: TextDirection.ltr,
            ),
            backgroundColor: Colors.black,
          ),
        )
    );

  }
}
