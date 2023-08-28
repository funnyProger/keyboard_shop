import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../CORE/models/basket_model.dart';

class BasketIconWidget extends StatelessWidget {
  const BasketIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var modelContext = context.watch<BasketModel>();
    if(modelContext.getProductMap().isEmpty) {
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
                    modelContext.getBasketCount().toString(),
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