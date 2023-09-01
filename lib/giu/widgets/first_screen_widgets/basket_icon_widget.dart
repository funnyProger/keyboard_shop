import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';
import 'package:provider/provider.dart';

class BasketIconWidget extends StatefulWidget {
  const BasketIconWidget({super.key});

  @override
  State<BasketIconWidget> createState() => BasketIconWidgetState();
}

class BasketIconWidgetState extends State<BasketIconWidget> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<BasketModel>().getBasketCount(),
      builder: (context, snapshot) {
        if (snapshot.data == 0 || snapshot.hasError) {
          return Container(
            width: 29,
            margin: const EdgeInsets.only(right: 15),
            child: Image.asset('assets/images/basket.png'),
          );
        } else {
          return Stack(
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
                      snapshot.data.toString(),
                      style: const TextStyle(fontSize: 11, color: Colors.white),
                      textDirection: TextDirection.ltr,
                    ),
                  ))
            ],
          );
        }
      },
    );
  }
}
